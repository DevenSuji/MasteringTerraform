resource "aws_instance" "myec2" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = lookup(var.instance_type, terraform.workspace)
}
