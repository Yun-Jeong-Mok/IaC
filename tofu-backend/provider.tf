terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.50.0"
    }
  }

  backend "s3" {
    bucket                      = "tofu-state"
    key                         = "tofu-backend/terraform.tfstate"
    endpoint                    = "http://repository:9000"
    region                      = "us-east-1"
    access_key                  = "minioadmin"
    secret_key                  = "minioadminpass"
    skip_credentials_validation = true
    skip_region_validation      = true
    force_path_style            = true
    skip_metadata_api_check     = true
  }
}

provider "openstack" {
  insecure = true
}
