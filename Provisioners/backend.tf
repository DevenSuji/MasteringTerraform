terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "devensuji"
    workspaces { 
      name = "exampro" 
    }
  }
}