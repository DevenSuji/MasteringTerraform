resource "aws_vpc" "prod_network" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "tf-prod-network"
    Owner = "DevenSuji@gmail.com"
    OfficeLocation = "Bangalore"
  }
}