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
  instance_type = lookup(var.instance_type, terraform.workspace)
}
variable "instance_type" {
  type = map(string)
  default = {
    default     = "t2.micro"
    development = "t2.nano"
    staging     = "t2.small"
    production  = "t2.large"
  }
}
