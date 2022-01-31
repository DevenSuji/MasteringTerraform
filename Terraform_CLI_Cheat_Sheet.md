# Terraform CLI Cheat Sheet

### ***<ins>Basic Commands</ins>***

***terraform init***

***terraform plan***

***terraform apply***

***terraform destroy***

### ***<ins>Outputs</ins>***

***terraform output***

***terraform output dbpassword***

***terraform output -json***

***terraform init -upgrade*** : Upgrade the AWS provider version. You can also use the -upgrade flag to downgrade the provider versions if the version constraints are modified to specify a lower provider version.

### ***<ins>Terraform Configuration</ins>***

***terraform show***

***terraform import***

### ***<ins>Terraform State</ins>***

***terraform state list*** : To get the list of resource names and local identifiers in your state file. 

***terraform state mv*** command moves resources from one state file to another.

***terraform state mv -state-out=../terraform.tfstate aws_instance.example_new aws_instance.example_new***

***terraform state rm*** subcommand removes specific resources from your state file. This does not remove the resource from your configuration or destroy the infrastructure itself.

***terraform refresh*** command updates the state file when physical resources change outside of the Terraform workflow.


### ***<ins>Terraform State</ins>***

***terraform plan -replace="aws_instance.example"***


### ***<ins>Miscellaneous</ins>***
***aws configure get region***