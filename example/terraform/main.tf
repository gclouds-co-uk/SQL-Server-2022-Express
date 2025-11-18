provider "google" {
  project = var.project_id
  default_labels = {
    goog-partner-solution = "isol_plb32_0014m00001jtg0yqaa_3rzgvkon7nnqxtml2ptezuxieijatzi5"
  }
}

locals {
  network_interfaces = [for i, n in var.networks : {
    network     = n,
    subnetwork  = length(var.sub_networks) > i ? element(var.sub_networks, i) : null
    external_ip = length(var.external_ips) > i ? element(var.external_ips, i) : "NONE"
    }
  ]

  metadata = {
    product                  = "ms-sql-server-2022-express"
    CU                       = "22"
    SQL                      = "2022"
    Version                  = "16.0.4225.2"
    google-logging-enable    = "0"
    google-monitoring-enable = "0"
  }
}

resource "google_compute_instance" "instance" {
  name         = "${var.goog_cm_deployment_name}-vm"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["${var.goog_cm_deployment_name}-deployment"]

  boot_disk {
    device_name = "autogen-vm-tmpl-boot-disk"

    initialize_params {
      size  = var.boot_disk_size
      type  = var.boot_disk_type
      image = var.source_image
    }
  }

  can_ip_forward = var.ip_forward

  metadata = local.metadata

  dynamic "network_interface" {
    for_each = local.network_interfaces
    content {
      network    = network_interface.value.network
      subnetwork = network_interface.value.subnetwork

      dynamic "access_config" {
        for_each = network_interface.value.external_ip == "NONE" ? [] : [1]
        content {
          nat_ip = network_interface.value.external_ip == "EPHEMERAL" ? null : network_interface.value.external_ip
        }
      }
    }
  }

  service_account {
    email = "default"
    scopes = compact([
      "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write"
    ])
  }
}

resource "google_compute_firewall" tcp_1433 {
  count = var.enable_tcp_1433 ? 1 : 0

  name    = "${var.goog_cm_deployment_name}-tcp-1433"
  network = element(var.networks, 0)

  allow {
    ports    = ["1433"]
    protocol = "tcp"
  }

  source_ranges = compact([for range in split(",", var.tcp_1433_source_ranges) : trimspace(range)])

  target_tags = ["${var.goog_cm_deployment_name}-deployment"]
}

resource "google_compute_firewall" udp_1434 {
  count = var.enable_udp_1434 ? 1 : 0

  name    = "${var.goog_cm_deployment_name}-udp-1434"
  network = element(var.networks, 0)

  allow {
    ports    = ["1434"]
    protocol = "udp"
  }

  source_ranges = compact([for range in split(",", var.udp_1434_source_ranges) : trimspace(range)])

  target_tags = ["${var.goog_cm_deployment_name}-deployment"]
}
