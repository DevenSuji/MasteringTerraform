terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

locals {
  common_tags = {
    Owner = "DevOps Team"
    Service = "Backend"
  }
}

resource "aws_instance" "dev" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"
  tags = local.common_tags
}


resource "aws_instance" "prod" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"
  tags = local.common_tags
}

resource "aws_ebs_volume" "db_ebs" {
  availability_zone = "ap-south-1a"
  size              = 2
  tags = local.common_tags
}