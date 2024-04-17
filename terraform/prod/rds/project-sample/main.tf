# ---------------------------------------------
# Terraform configuration
# ---------------------------------------------
terraform {
  required_version = ">=1.4.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket  = "terraform-project-sample-prod-1"
    key     = "rds/project-sample/terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "campbel2525"
  }
}

# ---------------------------------------------
# Provider
# ---------------------------------------------
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

provider "aws" {
  alias      = "virginia"
  region     = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# ---------------------------------------------
# Modules
# ---------------------------------------------
module "network" {
  source      = "../../modules/output/network"
  project     = var.project
  environment = var.environment
}

module "security_group" {
  source      = "../../modules/output/security_group"
  project     = var.project
  environment = var.environment
}
