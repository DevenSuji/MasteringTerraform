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

resource "aws_instance" "instance-1" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"
}
