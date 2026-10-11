terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
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

provider "oci" {
  tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaav3sbqm3azwxiuvxpinv4ueg67s4xvpcgsz5vvidj3wkrjergxlda"
  user_ocid        = "ocid1.user.oc1..aaaaaaaaquulymelffausdswjsrx3fnnhgh726imh7mn4o6xgdsxso6olxda"
  fingerprint      = "e3:04:45:84:47:3f:5f:39:95:70:3d:56:20:13:ea:10"
  private_key_path = "C:\\Users\\lenovo\\.oci\\oci_api_key.pem"
  region           = "ap-hyderabad-1"
}

# Ask OCI to list availability domains - a safe, read-only test
data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaav3sbqm3azwxiuvxpinv4ueg67s4xvpcgsz5vvidj3wkrjergxlda"
}

output "availability_domains" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

resource "oci_identity_compartment" "practice" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaav3sbqm3azwxiuvxpinv4ueg67s4xvpcgsz5vvidj3wkrjergxlda"
  name           = "terraform-practice-compartment"
  description    = "Created via Terraform for interview practice"
}

