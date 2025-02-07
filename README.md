# FortiGate

This module deploys a [FortiGate Next-Generation Firewall (BYOL)](https://console.cloud.google.com/marketplace/product/fortigcp-project-001/fortigate) from Marketplace.

## Inputs

| Name | Description | Type | Default | Nullable |
|------|-------------|------|---------|:--------:|
| boot\_disk\_size | The boot disk size for FortiGate in GBs | `string` | `"10"` | no |
| boot\_disk\_type | The boot disk type for the FortiGate. | `string` | `"pd-ssd"` | no |
| enable\_log\_disk | Enable log disk feature for FortiGate. | `bool` | n/a | yes |
| log\_disk\_size | The log disk size for FortiGate in GBs | `string` | `"10"` | no |
| log\_disk\_type | The log disk type for FortiGate. | `string` | `"pd-ssd"` | no |
| enable\_tcp\_8080 | Enable network traffic over tcp port 8080 for FortiGate | `bool` | `false` | no |
| enable\_tcp\_3000 | Enable network traffic over tcp port 3000 for FortiGate | `bool` | `false` | no |
| enable\_tcp\_541 | Enable network traffic over tcp port 541 for FortiGate | `bool` | `false` | no |
| enable\_tcp\_443 | Enable network traffic over tcp port 443 for FortiGate | `bool` | `false` | no |
| enable\_tcp\_80 | Enable network traffic over tcp port 80 for FortiGate | `bool` | `false` | no |
| enable\_tcp\_22 | Enable network traffic over tcp port 22 for FortiGate | `bool` | `false` | no |
| external\_ips | The external IPs assigned to the VM for public access. | `list(string)` | <pre>[<br>  "EPHEMERAL"<br>]</pre> | no |
| goog\_cm\_deployment\_name | The name of the deployment and VM instance. | `string` | n/a | yes |
| machine\_type | The machine type to create, e.g. e2-small | `string` | `"n2-standard-4"` | no |
| networks | The network name to attach the VM instance. | `list(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| project\_id | The ID of the project in which to provision resources. | `string` | n/a | yes |
| source\_image | The image name for the disk for the VM instance. | `string` | `"projects/fortigcp-project-001/global/images/fortinet-fgt-761-20241128-001-w-license"` | no |
| sub\_networks | The sub network name to attach the VM instance. | `list(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| tcp\_8080\_ip\_source\_ranges | A comma separated string of source IP ranges for accessing the VM instance over tcp port 8080. | `string` | n/a | yes |
| tcp\_3000\_ip\_source\_ranges | A comma separated string of source IP ranges for accessing the VM instance over tcp port 3000. | `string` | n/a | yes |
| tcp\_541\_ip\_source\_ranges | A comma separated string of source IP ranges for accessing the VM instance over tcp port 541. | `string` | n/a | yes |
| tcp\_443\_ip\_source\_ranges | A comma separated string of source IP ranges for accessing the VM instance over tcp port 443. | `string` | n/a | yes |
| tcp\_80\_ip\_source\_ranges | A comma separated string of source IP ranges for accessing the VM instance over tcp port 80. | `string` | n/a | yes |
| tcp\_22\_ip\_source\_ranges | A comma separated string of source IP ranges for accessing the VM instance over tcp port 22. | `string` | n/a | yes |
| zone | The zone for the solution to be deployed. | `string` | `"us-central1-b"` | no |
| enable\_ip\_forward | Forwarding allows the instance to help route packets. | `bool` | `true` | no |
| shielded\_vm | Enable Shielded VM Support. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| admin\_user | Admin username for FortiGate |
| admin\_password | Password for the admin user |
| arm64\_image | Check if the image is arm64 version |
| confidential\_vm\_enabled | Check if the confidential VM feature is enabled |
| has\_external\_ip | Flag to indicate if the FortiGate machine has an external IP |
| instance\_machine\_type | Machine type for the FortiGate compute instance |
| instance\_nat\_ip | Machine type for the FortiGate compute instance |
| instance\_network | Machine type for the FortiGate compute instance |
| instance\_self\_link | Self-link for the FortiGate compute instance |
| instance\_zone | Zone for the FortiGate compute instance |
| shielded\_vm\_enabled | Check if the shielded VM feature is enabled |