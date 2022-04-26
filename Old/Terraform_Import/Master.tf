resource "aws_instance" "Master" {
  ami                    = "ami-052cef05d01020f1d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0b477bb07904d78eb"]
  key_name               = "Master"
  subnet_id              = "subnet-0d26694991ff1c243"
  instance_state         = "running"
  tags  = {
    Name = "Master"
  }
}
# terraform import aws_instance.Master i-06e6c4953e55ee7ff