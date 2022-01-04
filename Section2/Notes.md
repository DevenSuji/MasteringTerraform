# Different ways of assigning variables in Terraform and their precedence.

Variables in terraform can be assigned in multiple ways. Some of these include
* Environment Variables.
* Command Line Flags
* From a file.
* Variables Defaults : This method requires us to create a file by the name variable.tf and define the data in the file. See the example below.
```terraform
variable "instancetype" {
    default = "t2.micro"
}
```
