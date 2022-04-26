terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_eip" "lb" {
  vpc = true
}

output "eip" {
  value = aws_eip.lb
}

resource "aws_s3_bucket" "myS3" {
  bucket = "deven-suji-bucket-demo-01"

}

output "mys3bucket" {
    value = aws_s3_bucket.myS3
}
