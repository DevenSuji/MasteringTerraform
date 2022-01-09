# ***<ins>Terraform</ins>***

## ***<ins>Section 2</ins>***

## ***<ins>terraform init</ins>***
terraform init scans the code for any of the providers (e.g. AWS, Azure, GCP, VMWare etc) being used by the code and download the provider's code.
By default the provider's code will be downloaded into .terraform folder.
It is always advisable to add .terraform to gitignore.

## ***<ins>terraform plan</ins>***
This command will let us see what terraform will do before actually making changes.  
Anylines with (+) will be created.  
Anylines with (-) will be deleted.  
Anylines with (~) will be modified in place.  

### ***<ins>Ways to define variables.</ins>***

***Variables in terraform can be assigned in multiple ways. Some of these include***
* ***Environment Variables:*** This method involves defining the variable and it's values as the environment variable.
```terraform
# For windows
setx TF_VARS_instancetype m5.large  
  
# For Mac and Linux
export TF_VARS_instancetype="m5.large"
```
* ***Command Line Flags:*** This method involves supplying the value of the variables in the command line. See the below example.
```terraform
terraform plan -var="instancetype=t2.small" 
terraform apply -var="instancetype=t2.small" 
```
* ***From a file :*** This method requires us to create a file by the name terraform.tfvars and define the data in the file. See the example below.
```terraform
instancetype = "t2.large"
```
* ***Variables Defaults :*** This method requires us to create a file by the name variable.tf and define the data in the file. See the example below.
```terraform
variable "instancetype" {
    default = "t2.micro"
}
```
### ***<ins>Type Constraints</ins>***

The type argument in the variable block allows you to restrict the type of value that will be accepted as the value for the variable. If no type constraint is set that value of any type is accepted.
```terraform
variable "image_id" {
    type = string
}
```

### ***<ins>Conditional Expression (If_Else Block)</ins>***

A conditional expression used the value of a boolean expression to select one of the two values.  
Syntax of Conditional Expression:
```terraform
contition ? true_value : false_value
```
The above condition says that if the condition is true then the result is true_value and if the condition is false then the result is false_value.
See below on how the actual code looks like and also ensure that a file by the name terraform.tfvars is created in the same directory with the value as istrue = true/false.
```terraform
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

variable "istest" {}

resource "aws_instance" "dev" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"
  count = var.istest == true ? 3 : 0
}


resource "aws_instance" "prod" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.large"
  count = var.istest == false ? 5 : 0
}
```

### ***<ins>Local Values</ins>***
If there is a command value that needs to be applied to the every configuraiton iteam then these values can be defined under the local resource type. See the example below.
```terraform
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

locals {
  common_tags = {
    Owner = "DevOps Team"
    Service = "Backend"
  }
}

resource "aws_instance" "dev" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"
  tags = local.common_tags
}


resource "aws_instance" "prod" {
  ami           = "ami-052cef05d01020f1d"
  instance_type = "t2.micro"
  tags = local.common_tags
}

resource "aws_ebs_volume" "db_ebs" {
  availability_zone = "ap-south-1a"
  size              = 2
  tags = local.common_tags
}
```
### ***<ins>Terraform Functions</ins>***

The Terraform language includes a number of built-in functions that we can use to transform and combine values.
The general syntax for the function is the name of the function followed by command seperated arguments in parenthesis.
```terraform
max(2, 3, 4)
```
Terraform language does not support user defined functions. Hence only the built in functions are at our displosal.

Documentation: https://www.terraform.io/language/functions



### ***<ins>Data Sources</ins>***

There are a lot of data that we've hard coded in the configuration file. But this is not the right way to write the configuration files.
Instead I'd want to query and find out the lastest data dynamically and use the same in the configuration file. One such data that we've been hardcoding is the ami id. 
Now the data block shown below will query aws for the latest ami id for the operation system that I want to deploy an EC2 instance with and insert the same data to the resource block. See the example below.
```terraform
data "aws_ami" "app_ami" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*"]
    }
}

resource "aws_instance" "instance-1" {
  ami = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
}
```
### ***<ins>Debugging in Terraform</ins>***

Terraform has detailed logs which can be enabled by setting the TF_LOG environment variable to any value.

We can set the TF_LOG to one of the log levels TRACE, DEBUG, INFO, WARN and ERROR to change the verbosity of the logs.
See below on how to change the log level in a Linux Box.
```bash
export TF_LOG=TRACE
```
The logs can also be saved to a file using the below command.
```bash
export TF_LOG_PATH=/tmp/terraform-crash.log
```

### ***<ins>Terraform Format</ins>***

To format the code in the terraform configuration file we can use the below command. Terraform will format the code in a readable format.
```bash
terraform fmt
```

### ***<ins>Terraform Validate</ins>***

This command validates if the configuration is syntactically valid.
If will various aspects including unsupported arguments, udeclared variables and others.
```bash
terraform validate
```
### ***<ins>Load Order and Semantics</ins>***
Terraform generally loads all the configuration file within the directory specified in an aplhabetical order. The files loaded must end in either .tf or .tf.json to specify the format in use.

### ***<ins>Dynamic Blocks</ins>***

Dynamic blocks are used in places where we have huge number of repeated blocks, however the value of the attributes are different. It just like a function in programming language to which we can supply different values. If we do not use the Dynamic Blocks then our code will be too lengthy.

```terraform
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

variable "sg_ports" {
  type        = list(number)
  description = "List of ingress ports to use for service groups"
  default     = [8200, 8201, 8300, 9200, 9500]
}

resource "aws_security_group" "dynamicsg" {
  name        = "dynamic-sg"
  description = "Ingress for vault"

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.sg_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```
### ***<ins>Terraform Taint</ins>***

Consider this scenario where you have created resources via Terraform and after the resource was provisioned users have made a lot of manual changes to the server and inside the server.  
  
There are two ways to deal with this issue:
* We can either import the change to the Terraform.
* We can delete and recreate the resource.
```bash
terraform taint aws_instance.instance-1
```

The ***terraform taint*** command manually marks a terraform managed resource as tainted, forcing it to be destroyed and recreated on the next apply.

***Important Notes About Taint***
* This command will not modify the infrastructure, but does modify the state file in order to mark a resource as tainted.
* Once a resource is marked as tainted, the next plan will show that the resource will be destroyed and recreated and the next apply will implement the change.
* Note that tainting a resource for recreation may affect resources that depend on the newly tainted resource. For e.g. If there is a dns entry that points to the ip of the resource then we need to keep a note of modifying the dns entry using terraform as well.

### ***<ins>Splat Expression</ins>***

Splat Expression allows us to get a list of all the attributes.

```terraform
resource "aws_iam_user" "lb" {
  name = "iamuser.${count.index}"
  count = 3
  path = "/system/"
}

output "arns" {
  value = aws_iam_user.lb[*].arn # The * here inside the square brackets is called splatting. LOL
}
```

### ***<ins>Terraform Graph</ins>***

The ***terraform graph*** command is used to generate a visual representation of either a configuration or an execution plan.  
The output of ***terraform graph*** command is in dot format and it can be easily be converted to and image file.
The below command will save the output to a file with the .dot extension and this .dot file can be easily converted to an image file.

```bash
terraform graph > filename.dot
```
### ***<ins>Terraform Plan File</ins>***

The generated terraform plan can be saved to a specific path. This plan can then be used with terraform apply to be certain that only the changes shown in this plan are applied.
```bash
terraform plan -out=filename
```

### ***<ins>Terraform Output</ins>***

```terraform
resource "aws_iam_user" "lb" {
  name = "iamuser.${count.index}"
  count = 3
  path = "/system/"
}

output "iam_names" {
  value = aws_iam_user.lb[*].name
}

output "iam_arns" {
  value = aws_iam_user.lb[*].arn
}
```
See the output below
```bash
iam_arns = [
  "arn:aws:iam::309673166815:user/system/iamuser.0",
  "arn:aws:iam::309673166815:user/system/iamuser.1",
  "arn:aws:iam::309673166815:user/system/iamuser.2",
]
iam_names = [
  "iamuser.0",
  "iamuser.1",
  "iamuser.2",
]
```
```bash
terraform output iam_arns
[
  "arn:aws:iam::309673166815:user/system/iamuser.0",
  "arn:aws:iam::309673166815:user/system/iamuser.1",
  "arn:aws:iam::309673166815:user/system/iamuser.2",
]
```
```bash
terraform output iam_names
[
  "iamuser.0",
  "iamuser.1",
  "iamuser.2",
]
```
### ***<ins>Dealing With Large Infrastructure</ins>***
When doing a ***terraform init, terraform plan and terraform apply*** there are a ot of api calls that are made to the AWS API Endpoint.   
There is a limit for the number of API Calls that can be made to AWS and if we hit this API query limit then things can be really bad.   
In order to limit the number of API calls there are few tricks that can be used.  
1. Preventing the refresh by using the ***terraform plan -refresh = false*** tag.  
```bash
terraform plan -refresh = false
```
2. By specifying the target resource that we made the change to using ***terraform plan -target=ec2***. This simply means that we've made change only to the EC2 resource and only the API calls belonging to EC2 resource will be made. This is generally used as a means to operate on isolated portions of very large configurations.
```bash
terraform plan -refresh = false -target = aws_instance.myec2
# Here we are assuming that we've made change only to the EC2 Instance Resource Block
```
## ***<ins>Section 3</ins>***

### ***<ins>Terraform Provisioners</ins>***
Provisioners are used to execute scripts on a local or remote machine as a part of resource creation or destruction. 
```terraform
resource "aws_instance" "myec2" {
  ami                    = "ami-052cef05d01020f1d"
  instance_type          = "t2.micro"
  key_name               = "Master"

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("/home/ec2-user/terraform.pem")

    }
  }
}
```

### ***<ins>Types Of Provisioners</ins>***
There are two types of provisioners:  
1. Local Exec
2. Remote Exec

* <ins>Local Exec</ins>: Local Exec allows us to invoke local executables after a resource is created.
```terraform
provisioner "local-exec" {
  command = "echo ${aws_instance.web.private_ip} >> private_ip.txt"
}
```
* <ins>Remote Exec</ins>: Remote Exec allows us to invoke scripts directly on the remote server.