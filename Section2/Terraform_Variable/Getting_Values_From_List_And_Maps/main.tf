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
  instance_type = var.list[2]
}

variable "list" {
  type = list(string)
  default = ["m5.large", "m5.xlarge", "m5.2xlarge"]
}

variable "types" {
  type = map(string)
  default = {
    "ap-south-1" = "t2.micro"
    "ap-southeast-1" = "t2.nano"
    "ap-southeast-2" = "t2.small"
  }
}