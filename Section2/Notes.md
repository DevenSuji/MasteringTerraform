# ***Terraform***

## ***Progress: Start from video 23***

### ***Ways to define variables.***

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
### ***Type Constraints***

The type argument in the variable block allows you to restrict the type of value that will be accepted as the value for the variable. If no type constraint is set that value of any type is accepted.
```terraform
variable "image_id" {
    type = string
}
```

### ***Conditional Expression (If_Else Block)***

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

### ***Local Values***
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
### ***Terraform Functions***

The Terraform language includes a number of built-in functions that we can use to transform and combine values.
The general syntax for the function is the name of the function followed by command seperated arguments in parenthesis.
```terraform
max(2, 3, 4)
```
Terraform language does not support user defined functions. Hence only the built in functions are at our displosal.

Documentation: https://www.terraform.io/language/functions


```python
a = [1, 2, 3, 4]
print(a)
```

### Learning Bash

The below command is used to lookup the ip address of the machine.

```bash
ip addr
```
