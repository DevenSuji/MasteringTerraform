# ***Terraform***

### Different ways of assigning variables in Terraform and their precedence.

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
