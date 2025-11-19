# Google Cloud Marketplace Terraform Module

This module deploys a product from Google Cloud Marketplace.

## Usage

The provided test configuration can be used by executing:

```
terraform plan --var-file marketplace_test.tfvars --var project_id=<YOUR_PROJECT>
```

## Inputs

| Name                    | Description                                                                                    | Type             | Default                                                                                | Required |
| ----------------------- | ---------------------------------------------------------------------------------------------- | ---------------- | -------------------------------------------------------------------------------------- | -------- |
| project_id              | The ID of the project in which to provision resources.                                         | `string`       | `null`                                                                               | yes      |
| goog_cm_deployment_name | The name of the deployment and VM instance.                                                    | `string`       | `null`                                                                               | yes      |
| source_image            | The image name for the disk for the VM instance.                                               | `string`       | `"projects/mpi-gclouds-public/global/images/gclouds-win2022-sql2022-exp-1763461623"` | no       |
| zone                    | The zone for the solution to be deployed.                                                      | `string`       | `"us-central1-a"`                                                                    | no       |
| machine_type            | The machine type to create, e.g. e2-small                                                      | `string`       | `"e2-standard-4"`                                                                    | no       |
| boot_disk_type          | The boot disk type for the VM instance.                                                        | `string`       | `"pd-ssd"`                                                                           | no       |
| boot_disk_size          | The boot disk size for the VM instance in GBs                                                  | `number`       | `80`                                                                                 | no       |
| networks                | The network name to attach the VM instance.                                                    | `list(string)` | `["default"]`                                                                        | no       |
| sub_networks            | The sub network name to attach the VM instance.                                                | `list(string)` | `[]`                                                                                 | no       |
| external_ips            | The external IPs assigned to the VM for public access.                                         | `list(string)` | `["EPHEMERAL"]`                                                                      | no       |
| ip_forward              | Whether to allow sending and receiving of packets with non-matching source or destination IPs. | `bool`         | `false`                                                                              | no       |
| enable_tcp_1433         | Allow TCP port 1433 traffic from the Internet                                                  | `bool`         | `true`                                                                               | no       |
| tcp_1433_source_ranges  | Source IP ranges for TCP port 1433 traffic                                                     | `string`       | `""`                                                                                 | no       |
| enable_udp_1434         | Allow UDP port 1434 traffic from the Internet                                                  | `bool`         | `true`                                                                               | no       |
| udp_1434_source_ranges  | Source IP ranges for UDP port 1434 traffic                                                     | `string`       | `""`                                                                                 | no       |

## Outputs

| Name                  | Description                                        |
| --------------------- | -------------------------------------------------- |
| instance_self_link    | Self-link for the compute instance.                |
| instance_zone         | Zone for the compute instance.                     |
| instance_machine_type | Machine type for the compute instance.             |
| instance_nat_ip       | External IP of the compute instance.               |
| instance_network      | Self-link for the network of the compute instance. |

## Requirements

### Terraform

Be sure you have the correct Terraform version (1.2.0+), you can choose the binary here:

https://releases.hashicorp.com/terraform/

### Configure a Service Account

In order to execute this module you must have a Service Account with the following project roles:

- `roles/compute.admin`
- `roles/iam.serviceAccountUser`

If you are using a shared VPC:

- `roles/compute.networkAdmin` is required on the Shared VPC host project.

### Enable API

In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API - `compute.googleapis.com`
