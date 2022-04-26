resource "aws_instance" "myec2" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"
}