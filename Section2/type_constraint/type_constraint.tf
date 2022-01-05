terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# provider "aws" {
#   region = "ap-south-1"
# }

# resource "aws_iam_user" "lb" {
#   name = var.number
#   path = "/system/"
# }