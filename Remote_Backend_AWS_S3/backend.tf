terraform {
  backend "s3" {
    bucket = "learning-terraform-remote-state"
    key    = "remote-state.tfstate"
    region = "ap-south-1"
    dynamodb_table = "s3-state-lock"
  }
}
