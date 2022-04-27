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

variable "elb_names" {
  type = list(string)
  default = [ "dev-loadbalancer", "stage-loadbalancer", "prod-loadbalancer" ]
}

resource "aws_iam_user" "user" {
  name = var.elb_names[count.index]
  count = 3
  path = "/system/"
}

# resource "aws_instance" "instance-1" {
#   ami           = "ami-052cef05d01020f1d"
#   instance_type = "t2.micro"
#   count = 3
#   tags = {
#     "name" = "masterserver.${count.index}"
#   }
# }
