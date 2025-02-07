variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

// Marketplace requires this variable name to be declared
variable "goog_cm_deployment_name" {
  description = "The name of the deployment and VM instance."
  type        = string
}

variable "zone" {
  description = "The zone for the solution to be deployed."
  type        = string
  default     = "us-central1-b"
}

variable "region" {
  description = "The region for the solution to be deployed."
  type        = string
  default     = "us-central1"
}

variable "source_image" {
  description = "The image name for the disk for the VM instance."
  type        = string
  default     = "projects/mpi-fortigcp-project-001/global/images/fortinet-fgt-762-20250130-001-w-license"
}

variable "machine_type" {
  description = "The machine type to create, e.g. e2-small"
  type        = string
  default     = "n2-standard-4"
}

variable "confidential_vm" {
  description = "Enable Confidential VM Support"
  type        = bool
  default     = false
}

variable "shielded_vm" {
  description = "Enable Shielded VM Support"
  type        = bool
  default     = false
}

variable "boot_disk_type" {
  description = "The boot disk type for the VM instance."
  type        = string
  default     = "pd-ssd"
}

variable "boot_disk_size" {
  description = "The boot disk size for the VM instance in GBs"
  type        = string
  default     = "10"
}

variable "enable_log_disk" {
  description = "Enable cloud logging for the VM instance."
  type        = bool
  default     = true
}

variable "log_disk_type" {
  description = "The log disk type for the VM instance."
  type        = string
  default     = "pd-ssd"
}

variable "log_disk_size" {
  description = "The log disk size for the VM instance in GBs"
  type        = string
  default     = "30"
}

variable "enable_tcp_22" {
  description = "Enable network traffic over port 22 for FortiGate"
  type        = bool
  default     = true
}

variable "tcp_22_ip_source_ranges" {
  description = "A comma separated string of source IP ranges for accessing the VM instance over TCP port 22."
  type        = string
  nullable    = true
}

variable "enable_tcp_80" {
  description = "Enable network traffic over port 80 for FortiGate"
  type        = bool
  default     = true
}

variable "tcp_80_ip_source_ranges" {
  description = "A comma separated string of source IP ranges for accessing the VM instance over HTTP port 80."
  type        = string
  nullable    = true
}

variable "enable_tcp_443" {
  description = "Enable network traffic over port 443 for FortiGate"
  type        = bool
  default     = true
}

variable "tcp_443_ip_source_ranges" {
  description = "A comma separated string of source IP ranges for accessing the VM instance over HTTPS port 443."
  type        = string
  nullable    = true
}

variable "enable_tcp_541" {
  description = "Enable network traffic over port 541 for FortiGate"
  type        = bool
  default     = true
}

variable "tcp_541_ip_source_ranges" {
  description = "A comma separated string of source IP ranges for accessing the VM instance over TCP port 541."
  type        = string
  nullable    = true
}

variable "enable_tcp_3000" {
  description = "Enable network traffic over port 3000 for FortiGate"
  type        = bool
  default     = true
}

variable "tcp_3000_ip_source_ranges" {
  description = "A comma separated string of source IP ranges for accessing the VM instance over TCP port 3000."
  type        = string
  nullable    = true
}

variable "enable_tcp_8080" {
  description = "Enable network traffic over port 8080 for FortiGate"
  type        = bool
  default     = true
}

variable "tcp_8080_ip_source_ranges" {
  description = "A comma separated string of source IP ranges for accessing the VM instance over TCP port 8080."
  type        = string
  nullable    = true
}

variable "enable_ip_forward" {
  description = "Enable IP Forwarding"
  type        = bool
  default     = true
}

variable "networks" {
  description = "The network name to attach the VM instance."
  type        = list(string)
  default     = ["default"]
}

variable "sub_networks" {
  description = "The sub network name to attach the VM instance."
  type        = list(string)
  default     = ["default"]
}

variable "external_ips" {
  description = "The external IPs assigned to the VM for public access."
  type        = list(string)
  default     = ["EPHEMERAL"]
}

# Criando IPs estáticos para interfaces privadas
variable "private_ips" {
  type    = list(string)
  default = []
}

variable "vm_service_account" {
  description = "The service account for the FortiGate VM to call Google Cloud APIs"
  type        = string
  nullable    = true
}