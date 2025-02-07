provider "google" {
  project = var.project_id
}

data "google_compute_default_service_account" "default" {}

resource "random_password" "admin_password" {
  length  = 8
  special = true
}

# Criando Reserva dos IPs Privados
resource "google_compute_address" "private_ips" {
  count        = length(var.private_ips)
  name         = "${var.goog_cm_deployment_name}-private-ip-${count.index}"
  region       = var.region
  subnetwork   = var.sub_networks[count.index]
  address      = var.private_ips[count.index]
  address_type = "INTERNAL"
}

# Criando um IP público reservado
resource "google_compute_address" "reserved_public_ip" {
  name   = "${var.goog_cm_deployment_name}-public-ip"
  region = var.region
}

locals {
  image_name       = element(split("/", var.source_image), 4)
  split_image_name = split("-", local.image_name)
  image_family     = substr(local.split_image_name[length(local.split_image_name) - 5], 0, 2)

  is_arm       = element(split("-", local.image_name), 2) == "arm64" ? true : false
  support_uefi = (local.image_family == "72" || local.image_family == "74" || local.image_family == "76") ? true : false

  machine_family              = element(split("-", var.machine_type), 0)
  confidential_vm_image_check = (local.image_family == "74" || local.image_family == "76") ? true : false
  support_confidential_vm     = local.machine_family == "n2d" && local.confidential_vm_image_check ? true : false

  network_interfaces = [for i, n in var.networks : {
    network     = n,
    subnetwork  = length(var.sub_networks) > i ? element(var.sub_networks, i) : null
    external_ip = length(var.external_ips) > i ? element(var.external_ips, i) : "NONE"
    internal_ip = length(var.private_ips) > i ? element(var.private_ips, i) : null
    }
  ]

  tcp_22_ip_source_ranges_map = var.enable_tcp_22 ? {
    "22" = split(",", var.tcp_22_ip_source_ranges)
  } : {}

  tcp_80_ip_source_ranges_map = var.enable_tcp_80 ? {
    "80" = split(",", var.tcp_80_ip_source_ranges)
  } : {}

  tcp_443_ip_source_ranges_map = var.enable_tcp_443 ? {
    "443" = split(",", var.tcp_443_ip_source_ranges)
  } : {}

  tcp_541_ip_source_ranges_map = var.enable_tcp_541 ? {
    "541" = split(",", var.tcp_541_ip_source_ranges)
  } : {}

  tcp_3000_ip_source_ranges_map = var.enable_tcp_3000 ? {
    "3000" = split(",", var.tcp_3000_ip_source_ranges)
  } : {}

  tcp_8080_ip_source_ranges_map = var.enable_tcp_8080 ? {
    "8080" = split(",", var.tcp_8080_ip_source_ranges)
  } : {}

  ip_source_ranges_map = merge(local.tcp_22_ip_source_ranges_map, local.tcp_80_ip_source_ranges_map, local.tcp_443_ip_source_ranges_map, local.tcp_541_ip_source_ranges_map, local.tcp_3000_ip_source_ranges_map, local.tcp_8080_ip_source_ranges_map)
}

#Log Disk
resource "google_compute_disk" "logdisk" {
  count                     = var.enable_log_disk ? 1 : 0
  name                      = "${var.goog_cm_deployment_name}-logdisk"
  size                      = var.log_disk_size
  type                      = var.log_disk_type
  zone                      = var.zone
  physical_block_size_bytes = 4096
}

# Instância FortiGate
resource "google_compute_instance" "fortigate" {
  name                      = var.goog_cm_deployment_name
  machine_type              = var.machine_type
  zone                      = var.zone
  can_ip_forward            = var.enable_ip_forward
  allow_stopping_for_update = true

  metadata = {
    fortigate_user_password = random_password.admin_password.result
  }

  boot_disk {
    initialize_params {
      size  = var.boot_disk_size
      type  = var.boot_disk_type
      image = var.source_image
    }
  }

  dynamic "scheduling" {
    for_each = var.confidential_vm && !local.is_arm && local.support_confidential_vm ? [1] : []
    content {
      on_host_maintenance = "TERMINATE"
    }
  }

  dynamic "confidential_instance_config" {
    for_each = var.confidential_vm && !local.is_arm && local.support_confidential_vm ? [1] : []
    content {
      enable_confidential_compute = true
    }
  }

  dynamic "shielded_instance_config" {
    for_each = var.shielded_vm && !local.is_arm && local.support_uefi ? [1] : []
    content {
      enable_secure_boot = true
    }
  }


  dynamic "network_interface" {
    for_each = local.network_interfaces
    content {
      network    = network_interface.value.network
      subnetwork = network_interface.value.subnetwork
      network_ip = network_interface.value.internal_ip

      dynamic "access_config" {
        for_each = network_interface.value.external_ip == "NONE" ? [] : [1]
        content {
          nat_ip = network_interface.value.external_ip == "EPHEMERAL" ? google_compute_address.reserved_public_ip.address : network_interface.value.external_ip
        }
      }
    }
  }
  tags = var.tcp_22_ip_source_ranges != "" || var.tcp_80_ip_source_ranges != "" || var.tcp_443_ip_source_ranges != "" || var.tcp_541_ip_source_ranges != "" || var.tcp_3000_ip_source_ranges != "" || var.tcp_8080_ip_source_ranges != "" ? ["${var.goog_cm_deployment_name}-deployment"] : []

  service_account {
    email = var.vm_service_account != "" ? var.vm_service_account : data.google_compute_default_service_account.default.email
    scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
    ]
  }
}

resource "google_compute_attached_disk" "logdisk_att" {
  count    = var.enable_log_disk ? 1 : 0
  disk     = google_compute_disk.logdisk[0].id
  instance = google_compute_instance.fortigate.id
}

#Network
resource "google_compute_firewall" "http" {
  for_each = local.ip_source_ranges_map
  project  = var.project_id
  name     = "${var.goog_cm_deployment_name}-tcp-${each.key}"
  network  = element(var.networks, 0)

  allow {
    protocol = "tcp"
    ports    = [each.key]
  }

  source_ranges = each.value
  target_tags   = ["${var.goog_cm_deployment_name}-deployment"]
}