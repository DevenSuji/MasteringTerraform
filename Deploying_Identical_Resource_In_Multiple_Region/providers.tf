provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias = "America"
  region = "us-east-1"
}

