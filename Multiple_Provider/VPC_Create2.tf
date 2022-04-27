resource "aws_vpc" "prod_vpc_virginia" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name           = "tf-prod-vpc-virginia"
    Owner          = "DevenSuji@gmail.com"
    OfficeLocation = "Virginia"
  }
}
