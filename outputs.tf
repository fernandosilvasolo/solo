locals {
  network_interface = google_compute_instance.fortigate.network_interface[0]
}

output "admin_user" {
  description = "Username for the admin user"
  value       = "admin"
}

output "admin_password" {
  description = "Password for the admin user"
  value       = random_password.admin_password.result
  sensitive   = true
}

output "has_external_ip" {
  description = "Flag to indicate if the FortiGate machine has an external IP"
  value       = length(compact(local.network_interface.access_config[*].nat_ip)) > 0 ? true : false
}

output "instance_machine_type" {
  description = "Machine type for the FortiGate compute instance"
  value       = var.machine_type
}

output "instance_nat_ip" {
  description = "Machine type for the FortiGate compute instance"
  value       = length(local.network_interface.access_config) > 0 ? local.network_interface.access_config[0].nat_ip : null
}

output "instance_network" {
  description = "Network for the FortiGate compute instance"
  value       = local.network_interface.network
}

output "instance_self_link" {
  description = "Self-link for the FortiGate compute instance"
  value       = google_compute_instance.fortigate.self_link
}

output "instance_zone" {
  description = "Zone for the FortiGate compute instance"
  value       = var.zone
}

output "arm64_image" {
  description = "ARM based VM image"
  value       = local.is_arm
}

output "shielded_vm_enabled" {
  description = "Shielded VM Enabled"
  value       = var.shielded_vm && !local.is_arm && local.support_uefi ? true : false
}

output "confidential_vm_enabled" {
  description = "Confidential VM Enabled"
  value       = var.confidential_vm && !local.is_arm && local.support_confidential_vm ? true : false
}

output "vm_service_account" {
  description = "The service account for the FortiGate VM to call Google Cloud APIs"
  value       = var.vm_service_account != "" ? var.vm_service_account : data.google_compute_default_service_account.default.email
}