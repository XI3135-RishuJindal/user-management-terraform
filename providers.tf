terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.40.0"
    }
  }
  backend "s3" {
    bucket         = "tfstate-user-mgmt-dev-95bd4e80"
    key            = "user-mgmt/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-lock-user-mgmt-dev"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}