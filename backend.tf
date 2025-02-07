  terraform {
    backend "gcs" {
      bucket = "state-vm-fortigate"
      prefix = "terraform/fortigate"
    }
  }