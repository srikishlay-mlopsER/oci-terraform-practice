terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
  backend "s3" {
    bucket                      = "state-file-terraform"
    key                         = "terraform.tfstate"
    region                      = "ap-hyderabad-1"
    endpoints                   = { s3 = "https://axozdpqzkcfr.compat.objectstorage.ap-hyderabad-1.oraclecloud.com" }
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
}

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = pathexpand("~/.oci/oci_api_key.pem")
  region           = "ap-hyderabad-1"
}

# Ask OCI to list availability domains - a safe, read-only test
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

output "availability_domains" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

resource "oci_identity_compartment" "practice" {
  compartment_id = var.tenancy_ocid
  name           = "terraform-practice-compartment"
  description    = "Created via Terraform for interview practice"
}