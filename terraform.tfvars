project_id              = "zlr-hub-security"
goog_cm_deployment_name = "vm-fortigate-prd-teste"
zone                    = "us-east4-a"
region                  = "us-east4"
source_image            = "projects/mpi-fortigcp-project-001/global/images/fortinet-fgt-7210-20240920-001-w-license"
machine_type            = "n2-standard-4"

#Config VM
confidential_vm = false
shielded_vm     = false
boot_disk_type  = "pd-ssd"
boot_disk_size  = "10"
enable_log_disk = true
log_disk_type   = "pd-standard"
log_disk_size   = "30"

#FIREWALL
enable_tcp_22             = true
tcp_22_ip_source_ranges   = "191.241.129.114,189.1.153.238,186.201.185.234,186.225.100.61,177.55.63.158,189.108.200.244,189.20.126.2,201.90.86.2,20.22.199.231,84.199.77.245,187.95.156.48/29,189.114.224.208/29,170.231.14.184/32"
enable_tcp_80             = true
tcp_80_ip_source_ranges   = "191.241.129.114,189.1.153.238,186.201.185.234,186.225.100.61,177.55.63.158,189.108.200.244,189.20.126.2,201.90.86.2,20.22.199.231,84.199.77.245,187.95.156.48/29,189.114.224.208/29,170.231.14.184/32"
enable_tcp_443            = true
tcp_443_ip_source_ranges  = "191.241.129.114,189.1.153.238,186.201.185.234,186.225.100.61,177.55.63.158,189.108.200.244,189.20.126.2,201.90.86.2,20.22.199.231,84.199.77.245,187.95.156.48/29,189.114.224.208/29,170.231.14.184/32"
enable_tcp_541            = true
tcp_541_ip_source_ranges  = "191.241.129.114,189.1.153.238,186.201.185.234,186.225.100.61,177.55.63.158,189.108.200.244,189.20.126.2,201.90.86.2,20.22.199.231,84.199.77.245,170.231.14.184/32,189.114.224.208/29,187.95.156.48/29"
enable_tcp_3000           = true
tcp_3000_ip_source_ranges = "191.241.129.114,189.1.153.238,186.201.185.234,186.225.100.61,177.55.63.158,189.108.200.244,189.20.126.2,201.90.86.2,20.22.199.231,84.199.77.245,170.231.14.184/32,189.114.224.208/29,187.95.156.48/29"
enable_tcp_8080           = true
tcp_8080_ip_source_ranges = "191.241.129.114,189.1.153.238,186.201.185.234,186.225.100.61,177.55.63.158,189.108.200.244,189.20.126.2,201.90.86.2,20.22.199.231,84.199.77.245,170.231.14.184/32,189.114.224.208/29,187.95.156.48/29"
enable_ip_forward         = true

#NETWORK
networks           = ["vpc-zlr-hub", "vpc-zlr-dmz", "vpc-zlr-prod"]
sub_networks       = ["subnet-zlr-hub-us-east4", "subnet-zlr-dmz-us-east4", "subnet-zlr-prod-us-east4"]
private_ips        = ["10.228.0.4", "10.232.2.4", "10.226.0.4"]
external_ips       = ["EPHEMERAL"]
vm_service_account = "fortigate-vm@zlr-hub-security.iam.gserviceaccount.com"