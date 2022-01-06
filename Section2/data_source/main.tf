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

# The below data block stores the ami id of the latest ami id of amazon linux
data "aws_ami" "app_ami" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*"]
    }
}

resource "aws_instance" "instance-1" {
  ami = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
}
