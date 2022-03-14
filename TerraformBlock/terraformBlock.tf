# Terraform Block
terraform {
  required_version = ">= 1.1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  profile = "default" # This is an optional field. Even if we do not mention it, it will be set to default.
}
