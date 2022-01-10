
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

resource "aws_instance" "myec2" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.myec2.private_ip} >> private_ip.txt"
  }
}

