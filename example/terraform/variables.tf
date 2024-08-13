variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

// Marketplace requires this variable name to be declared
variable "goog_cm_deployment_name" {
  description = "The name of the deployment and VM instance."
  type        = string
}

variable "source_image" {
  description = "The image name for the disk for the VM instance."
  type        = string
  default     = "projects/mpi-gclouds-public/global/images/gclouds-win2022-sql2022-exp-1718494319"
}

variable "zone" {
  description = "The zone for the solution to be deployed."
  type        = string
  default     = "us-central1-a"
}

variable "machine_type" {
  description = "The machine type to create, e.g. e2-small"
  type        = string
  default     = "e2-standard-4"
}

variable "boot_disk_type" {
  description = "The boot disk type for the VM instance."
  type        = string
  default     = "pd-ssd"
}

variable "boot_disk_size" {
  description = "The boot disk size for the VM instance in GBs"
  type        = number
  default     = 80
}

variable "networks" {
  description = "The network name to attach the VM instance."
  type        = list(string)
  default     = ["default"]
}

variable "sub_networks" {
  description = "The sub network name to attach the VM instance."
  type        = list(string)
  default     = []
}

variable "external_ips" {
  description = "The external IPs assigned to the VM for public access."
  type        = list(string)
  default     = ["EPHEMERAL"]
}

variable "ip_forward" {
  description = "Whether to allow sending and receiving of packets with non-matching source or destination IPs."
  type        = bool
  default     = false
}

variable "enable_tcp_1433" {
  description = "Allow TCP port 1433 traffic from the Internet"
  type        = bool
  default     = true
}

variable "tcp_1433_source_ranges" {
  description = "Source IP ranges for TCP port 1433 traffic"
  type        = string
  default     = ""
}

variable "enable_udp_1434" {
  description = "Allow UDP port 1434 traffic from the Internet"
  type        = bool
  default     = true
}

variable "udp_1434_source_ranges" {
  description = "Source IP ranges for UDP port 1434 traffic"
  type        = string
  default     = ""
}
