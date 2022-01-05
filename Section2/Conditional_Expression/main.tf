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

variable "istest" {}

resource "aws_instance" "dev" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"
  count = var.istest == true ? 3 : 0
}


resource "aws_instance" "prod" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.large"
  count = var.istest == false ? 5 : 0
}