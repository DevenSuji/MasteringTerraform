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


***terraform import***

### ***<ins>Terraform State</ins>***

***terraform show*** Gets a human-friendly output of the resources contained in your state.

The -replace flag allows you to target specific resources and avoid destroying all the resources in your workspace just to fix one of them. In older versions of Terraform, you may have used the terraform taint command to achieve a similar outcome. That command has now been deprecated in favor of the -replace flag, which allows for a simpler, less error-prone workflow. 
```bash
terraform plan -replace="aws_instance.example"
terraform apply -replace="aws_instance.example"
```

***terraform state list*** : To get the list of resource names and local identifiers in your state file. 

***terraform state mv*** command moves resources from one state file to another. You can also rename resources with mv. The move command will update the resource in state, but not in your configuration file. Moving resources is useful when you want to combine modules or resources from other states, but do not want to destroy and recreate the infrastructure. 

***terraform state mv -state-out=../terraform.tfstate aws_instance.example_new aws_instance.example_new***

***terraform state rm*** subcommand removes specific resources from your state file. This does not remove the resource from your configuration or destroy the infrastructure itself.

***terraform refresh*** command updates the state file when physical resources change outside of the Terraform workflow.

***terraform plan -refresh-only*** Terraform's -refresh-only mode safely compares your infrastructure and state file without actually making a change to the state file. 

***terraform apply -refresh-only*** Terraform's -refresh-only mode safely compares your infrastructure and state file without actually making a change to the state file.

### ***<ins>Terraform State</ins>***

***terraform plan -replace="aws_instance.example"***


### ***<ins>Miscellaneous</ins>***
***aws configure get region***