resource "aws_vpc" "prod_vpc_bangalore" {
  cidr_block = "10.0.0.0/16"
  provider   = aws.aws-us-west-1

  tags = {
    Name = "tf-prod-vpc-bangalore"
    Owner = "DevenSuji@gmail.com"
    OfficeLocation = "Bangalore"
  }
}