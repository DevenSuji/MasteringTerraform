terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH into VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Note that the EGRESS Block is removed here so that the ec2 instance is not able to connect to the internet and download nano. 
  # This is done to simulate the failure scenario and we know that upon failure the ec2 instance will be marked as tainted. 
  # However if we uncomment the line 37 below the resource will not be marked as tainted.
}

resource "aws_instance" "myec2" {
  ami                    = "ami-052cef05d01020f1d"
  instance_type          = "t2.micro"
  key_name               = "terraform"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  provisioner "remote-exec" {
    on_failure = continue
    inline = [
      "sudo yum -y install nano"
    ]
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./terraform.pem")
    host        = self.public_ip
  }
}