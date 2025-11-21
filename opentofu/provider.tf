terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.50.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }

  }

backend "s3" {
    bucket                      = "tofu-state"           
    key                         = "main/terraform.tfstate" 
    endpoint                    = "http://repository:9000"
    region                      = "us-east-1"
    access_key                  = "minioadmin"
    secret_key                  = "minioadminpass"
    use_path_style              = true             
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
  }
}


provider "openstack" {
  insecure = true
}
provider "tls" {}
provider "local" {}
