#provider "aws" {

#  region                  = var.region
#  shared_credentials_file = var.shared_credentials_file
#}


terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.19.0"
    }
  }
}

provider "aws" {
	region	=	var.region
# Configuration options
}
