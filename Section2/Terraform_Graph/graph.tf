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
}

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true
}

resource "aws_security_group" "allow_tls" {
  name = "allow-tls"
  ingress = {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.lb.private_ip}/32"]
  }
}