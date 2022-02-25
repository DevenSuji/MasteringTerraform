# ***<ins>Terraform</ins>***

## ***<ins>Terraform Providers</ins>***
A provider is responsible for understanding API interactions and exposing resources.  
  
Most of the available providers correspond to one cloud or on-premises infrastructure platform and offer resource types that correspond to each of the features of that platform.

You can explicitly set a specific version of the provider within the provider block.

There are two ways for you to manage provider versions in your configuration.

* Specify provider version constraints in your configuration's terraform block.
* Use the dependency lock file.

To upgrade to the latest acceptable version of each provider, run terraform init -upgrade

To see the list of providers that the config file is using use the below command.
```bash
terraform providers
```

## ***<ins>Multiple Provider Instances</ins>***

You can have multiple provider instances with the help of an alias

```terraform
provider "aws" {
  region = "us-east-1"
}
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}
```
The provider block without alias set is known as the default provider configuration. When an alias is set, it creates an additional provider configuration.

## ***<ins>terraform init</ins>***
The terraform init command is used to initialize a working directory containing Terraform configuration files.

During init, the configuration is searched for module blocks, and the source code for referenced modules is retrieved from the locations given in their source arguments.  
  
Terraform must initialize the provider before it can be used.

Initialization downloads and installs the provider's plugin so that it can later be executed.

It will not create any sample files like example.tf


## ***<ins>terraform plan</ins>***
The terraform plan command is used to create an execution plan.

It will not modify things in infrastructure.

Terraform performs a refresh, unless explicitly disabled, and then determines what actions are necessary to achieve the desired state specified in the configuration files.

This command is a convenient way to check whether the execution plan for a set of changes matches your expectations without making any changes to real resources or to the state.

This command will let us see what terraform will do before actually making changes.  
Anylines with (+) will be created.  
Anylines with (-) will be deleted.  
Anylines with (~) will be modified in place.  

## ***<ins>terraform apply</ins>***
The terraform apply command is used to apply the changes required to reach the desired state of the configuration.  
Terraform apply will also write data to the terraform.tfstate file.  
Once apply is completed, resources are immediately available.

## ***<ins>terraform refresh and refresh-only</ins>***
The terraform refresh command is used to reconcile the state Terraform knows about (via its state file) with the real-world infrastructure.
This does not modify infrastructure but does modify the state file.

## ***<ins>terraform destroy</ins>***
The terraform destroy command is used to destroy the Terraform-managed infrastructure.  
terraform destroy command is not the only command through which infrastructure can be destroyed.
The other way to destroy a resource is by simply going to the configuration file and removing the resource. When terraform is applied, the intended resource will get wiped out.

## ***<ins>terraform format</ins>***

It simply formats the terraform code as per the convention.

## ***<ins>terraform validate</ins>***
The terraform validate command validates the configuration files in a directory.

Validate runs checks that verify whether a configuration is syntactically valid and thus primarily useful for general verification of reusable modules, including the correctness of attribute names and value types.

It is safe to run this command automatically, for example, as a post-save check in a text editor or as a test step for a reusable module in a CI system. It can run before terraform plan.

Validation requires an initialized working directory with any referenced plugins and modules installed.

## ***<ins>terraform provisioners</ins>***
Provisioners can be used to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service. The action could vary from installing softwares and editing files etc.

Provisioners should only be used as a last resort. For most common situations, there are better alternatives.

Provisioners are inside the resource block.

Have an overview of local and remote provisioner
```terraform
resource "aws_instance" "web" {
  # ...
  provisioner "local-exec" {
    command = "echo The server IP address is ${self.private_ip}"
  }
}
```
## ***<ins>Debugging In Terraform</ins>***
Terraform has detailed logs that can be enabled by setting the TF_LOG environment variable to any value.

You can set TF_LOG to one of the log levels TRACE, DEBUG, INFO, WARN or ERROR to change the verbosity of the logs.

Example:

TF_LOG=TRACE

To persist logged output, you can set TF_LOG_PATH


## ***<ins>Terraform Import</ins>***
Terraform is able to import existing infrastructure. 

This allows you to take resources that you've created by some other means and bring it under Terraform management.

The current implementation of Terraform import can only import resources into the state. It does not generate configuration.

Because of this, prior to running terraform import, it is necessary to write a resource configuration block manually for the resource, to which the imported object will be mapped.

```bash
terraform import aws_instance.myec2 instance-id
```
## ***<ins>Local Values</ins>***

  
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
### ***<ins>Terraform Variable Types</ins>***

Strings
```terraform
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
```
Numbers
```terraform
variable "instance_count" {
  description = "Number of instances to provision."
  type        = number
  default     = 2
}
```
Bool
```terraform
variable "enable_vpn_gateway" {
  description = "Enable a VPN gateway in your VPC."
  type        = bool
  default     = false
}
```

Terraform also supports collection variable types that contain more than one value. Terraform supports several collection variable types as listed below:

List: A sequence of values of the same type.
```terraform
variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets."
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24",
    "10.0.8.0/24",
  ]
}
```
Map: A lookup table, matching keys to values, all of the same type.
```terraform
variable "resource_tags" {
  description = "Tags to set for all resources"
  type        = map(string)
  default     = {
    project     = "project-alpha",
    environment = "dev"
  }
}
```

Set: An unordered collection of unique values, all of the same type.

Lists and maps are collection types. Terraform also supports two structural types. Structural types have a fixed number of values that can be of different types.

Tuple: A fixed-length sequence of values of specified types.
Object: A lookup table, matching a fixed set of keys to values of specified types.

### ***<ins>Terraform Variable Loading.</ins>***
Terraform automatically loads all files in the current directory with the exact name terraform.tfvars or matching *.auto.tfvars. One can also use the -var-file flag to specify other files by name.

### ***<ins>Terraform Variable Precedence.</ins>***
Below is the terraform variable precedence with the highest precedence at the top and the lowest precedence at the bottom.
| Variable Precedence |
| :---: | 
| -var and -var-file |
| *.auto.tfvars or *.auto.tfvars.json |
| terraform.tfvars.json |
| terraform.tfvars |
| Environment Variables |

### ***<ins>Interpolate variables in strings</ins>***
Terraform configuration supports string interpolation — inserting the output of an expression into a string. This allows you to use variables, local values, and the output of functions to create strings in your configuration.

Updating the names of the security groups to use the project and environment values from the resource_tags map using the interpolation.

```terraform
 module "app_security_group" {
   source  = "terraform-aws-modules/security-group/aws//modules/web"
   version = "3.12.0"

-  name        = "web-sg-project-alpha-dev"
# Below line is the example of string interpolation
+  name        = "web-sg-${var.resource_tags["project"]}-${var.resource_tags["environment"]}"

   description = "Security group for web-servers with HTTP ports open within VPC"
   vpc_id      = module.vpc.vpc_id

   ingress_cidr_blocks = module.vpc.public_subnets_cidr_blocks

   tags = var.resource_tags
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

### ***<ins>Provisioners</ins>***

* <ins>Local Exec</ins>: Local Exec allows us to invoke local executables after a resource is created. Local Exec will execute on the machine where the terraform has been invoked from (local machine).
```terraform
provisioner "local-exec" {
  command = "echo ${aws_instance.web.private_ip} >> private_ip.txt"
}
```
* <ins>Remote Exec</ins>: Remote Exec allows us to invoke scripts directly on the remote server.
```terraform
resource "aws_instance" "myec2" {
  ami                    = "ami-052cef05d01020f1d"
  instance_type          = "t2.micro"
  key_name               = "terraform"

  # This is the remote exec provisioner
  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./terraform.pem")

    }
  }
}
```
Remote Exec (Remote Command) has has three different modes:  

* InLine: List of command strings.
* Script: Relative or absolute local script that will be copied to the remote resource then executed.
* Scripts: Relative or absolute local scripts that will be copied to the remote resource then executed and executed in order. 

One can only choose to use one mode at a time.

### ***<ins>Types Of Provisioners</ins>***
There are two primary types of Provisioners
#### ***<ins>Creation Time Provisioner</ins>***
Creation Time Provisioner are only run during the creation and not during updating or any other life cycle.  
If a creation time provisioner fails, then the resource is marked as tainted.
#### ***<ins>Destroy Time Provisioner</ins>***
Destroy Time Provisioner run before the resource is destroyed.

### ***<ins>Terraform Workspace</ins>***

Workspace in Terrform is a completely seperate environment. Just like linux namespace.

To see the current workspace that we are on use the below command.
```bash
terraform workspace show
```

To see a list of workspaces that are available on our machine.
```bash
terraform workspace list
```

To create a new workspace use the below command. Note that when you create a new workspace, the command will automatically switch to the newly created workspace.
```bash
terrform workspace new development
```

To switch to an already existing workspace
```bash
terraform workspace select NameOfTheWorkSpace
```

To delete an already existing workspace
```bash
terraform workspace delete NameOfTheWorkSpace
```
### ***<ins>Location Of Terraform Workspace Directory</ins>***
By default the terraform.tfstate file will be created on the root directory if we are running the terraform apply command on the default workspace. 
   
However, if we are on any other custom workspace for example development workspace, then the terraform.tfstate file will be created within terraform.tfstate.d/development directory.


### ***<ins>AWS S3 as Terraform Remote Backend</ins>***
Here we will use an AWS S3 bucket to store the terraform.tfstate file and use the dynamodb to perform the state lock operation.  
1. Create a S3 Bucket.
2. Create a Dynamo DB Table giving the Table name and Partition key as LockID.
3. Configure the backend.tf file as shown below.
```terraform
terraform {
  backend "s3" {
    bucket = "Name_Of_The_S3_Bucket"
    key    = "remote-state.tfstate"
    region = "ap-south-1"
    dynamodb_table = "Name_Of_The_DynamoDB_Table"
  }
}
```
4. Run terraform init and terraform plan and the state locking will work now.


### ***<ins>Terraform Cloud as Remote Backend</ins>***
Setup the backend.tf file as shown below.
```terraform
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "NameOfOrganizationInTerraformCloud"
    workspaces { 
      name = "NameOfTheWorkSpaceInTerraformCloud" 
    }
  }
}
```
1. Create a new Organisation in Terraform Cloud.
2. Create a new cli driven workspace.
3. Type terraform login and then type yes. This will open a browser with the terraform api token. Generate a new token if needed. Copy the token and paste the same in the command line on your machine.
4. Supply terraform init in the command line and it will give you the below output.
```bash
terraform init

Initializing the backend...

Successfully configured the backend "remote"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v3.73.0...
- Installed hashicorp/aws v3.73.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
5. You are all set with your remote backend as terraform cloud.

### ***<ins>Migrating Terraform Remote Backend from AWS S3 or Terraform Cloud to Local Mahcine</ins>***

1. Comment or delete the backend file/configuration.
2. Run the command terraform init -migrate-state.
```bash
terraform init -migrate-state
```
3. You should have the terraform.tfstate file created locall only your machine now.

### ***<ins>Terraform State Management Using Commands</ins>***
As our terraform state file keeps growing as we'll be adding more and more resources to the configurtion file. There will be some use cases where we have to manually modify the terraform.tfstate file.  
  
It is very important to never modify the state file directly. Instead make use of terraform state command.

| State Sub Command | Description | 
| :---: | :---: |
| list | List resources within terraform state file. | 
| mv | Moves item with terraform state. |
| pull | Manually download and output the state from remote state. |
| push | Manually upload a local state file to remote state. |
| rm | Remove the resource from terraform state file only. But the resource does not get deleted in the actual infra.|
| show | Show the attribute of single resource in a terraform state. |

Listing the resources in the terraform state file.
```bash
terraform state list
```
Renaming the aws_instance from webapp to myec2
```bash
terraform state mv aws_instance.webapp aws_instance.myec2
```
Pulling a remote state file
```bash
terraform state pull
```
### ***<ins>Using ALIAS to deploy identical resource to multiple regions</ins>***
See below on how we've used the alias attribute to deploy identical resource to multiple regions.

provider.ft file

```terraform
provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias = "America"
  region = "us-east-1"
}
```

eip.tf

```terraform
resource "aws_eip" "myeip" {
  vpc = true
}

resource "aws_eip" "myeip1" {
  vpc = true
  provider = aws.America
}
```
### ***<ins>Deploying Multiple Resources in Different Accounts</ins>***
Ensure that the credentials for the other accounts is defined in the .aws/credentials file.
```terraform
provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias = "America"
  region = "us-east-1"
  profile = account2
}

provider "aws" {
  alias = "Europe"
  region = "europe-east-1"
  profile = account3
}
```

eip.tf

```terraform
resource "aws_eip" "myeip" {
  vpc = true
}

resource "aws_eip" "myeip1" {
  vpc = true
  provider = aws.America
}

resource "aws_eip" "myeip1" {
  vpc = true
  provider = aws.Europe
}
```
### ***<ins>Sentinel Policy Set</ins>***
Sentinel is an embedded policy-as-code framework integrated with various HashiCorp products. It enables fine-grained, logic-based policy decisions, and can be extended to use information from external sources. Terraform Cloud enables users to enforce policies during runs.

A policy consists of:

* The policy controls defined as code
* An enforcement level that changes how a policy affects the run lifecycle

sentinel.hcl defines the policy set. This configuration declares a policy named allowed-terraform-version and sets a soft-mandatory enforcement level. You can define multiple policy blocks in the sentinel.hcl file to configure more policies.
```terraform
policy "allowed-terraform-version" {
    enforcement_level = "soft-mandatory"
}
```
Enforcement levels in Terraform Cloud define behavior when policies fail to evaluate successfully. Sentinel provides three enforcement modes.

* Hard-mandatory requires that the policy passes. If a policy fails, the run is halted and may not be applied until the failure is resolved.

* Soft-mandatory is similar to hard-mandatory, but allows an administrator to override policy failures on a case-by-case basis.

* Advisory will never interrupt the run, and instead will only surface policy failures as informational to the user.

### ***<ins>Null Resource</ins>***
null_resource is a place holder for resources that have no specific association to a provider resources.
The null_resource implements the standard resource lifecycle but takes no further action.
The triggers argument allows specifying an arbitrary set of values that, when changed, will cause the resource to be replaced.
The primary use-case for the null resource is as a do-nothing container for arbitrary actions taken by a provisioner.

In this example, three EC2 instances are created and then a null_resource instance is used to gather data about all three and execute a single action that affects them all. Due to the triggers map, the null_resource will be replaced each time the instance ids change, and thus the remote-exec provisioner will be re-run.

```terraform
resource "aws_instance" "cluster" {
  count = 3
}


resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = join(",", aws_instance.cluster.*.id)
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = element(aws_instance.cluster.*.public_ip, 0)
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the clutser
    inline = [
      "bootstrap-cluster.sh ${join(" ", aws_instance.cluster.*.private_ip)}",
    ]
  }
}
```
### ***<ins>Upgrade the AWS provider version</ins>***

The -upgrade flag will upgrade all providers to the latest version consistent within the version constraints previously established in your configuration.
```bash
terraform init -upgrade
```
One can also use the -upgrade flag to downgrade the provider versions if the version constraints are modified to specify a lower provider version.

### ***<ins>Terraform Supported VCS Providers</ins>***
Terraform Cloud supports the following VCS providers as of January 2022:

  - GitHub
  - GitHub.com (OAuth)
  - GitHub Enterprise
  - GitLab.com
  - GitLab EE and CE
  - Bitbucket Cloud
  - Bitbucket Server
  - Azure DevOps Server
  - Azure DevOps Services


Terraform is available for 

* macOS
* FreeBSD
* OpenBSD
* Linux
* Solaris
* Windows 

### ***<ins>Replace a resource with CLI</ins>***

Terraform usually only updates your infrastructure if it does not match your configuration. You can use the -replace flag for terraform plan and terraform apply operations to safely recreate resources in your environment even if you have not edited the configuration, which can be useful in cases of system malfunction.
Replacing a resource is also useful in cases where a user manually changes a setting on a resource or when you need to update a provisioning script. This allows you to rebuild specific resources and avoid a full terraform destroy operation on your configuration. The -replace flag allows you to target specific resources and avoid destroying all the resources in your workspace just to fix one of them.
```bash
terraform plan -replace="aws_instance.example"
terraform apply -replace="aws_instance.example" -auto-approve
```

### ***<ins>Move a resource to a different state file</ins>***
The terraform state mv command moves resources from one state file to another. You can also rename resources with mv. The move command will update the resource in state, but not in your configuration file. Moving resources is useful when you want to combine modules or resources from other states, but do not want to destroy and recreate the infrastructure.

# Learnings for Kalyan Reddy Daida

### ***<ins>Terraform Top Level Blocks</ins>***
* Terraform Settings Block.
* Provider Block.
* Resource Block.
* Input Variables Block.
* Output Values Block.
* Local Values Block.
* Data Sources Block.
* Modules Block.

### Terraform Top Level Blocks can be categorized into below three categories:
#### 1. Fundamental Block
* <u><b>Terraform Block:</b></u> This is a special block which is used to configure some behaviours. It will inculde the details listed below:
- Required Terraform Versions.
- The list of Required Providers.
- Terraform backend information. 
* <u><b>Provider Block:</b></u>
* <u><b>Resource Block:</b></u>
#### 2. Variables Block
* <u><b>Input Variables Block:</b></u>
* <u><b>Output Values Block:</b></u>
* <u><b>Local Values Block:</b></u>
#### 3. Calling/Referencing Block
* <u><b>Data Sources Block:</b></u>
* <u><b>Modules Block:</b></u>

