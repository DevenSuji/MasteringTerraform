variable "elb_name" {
    description = "The name of the Elastic Load Balancer"
    type = string
    default = "elb-test"
}

variable "az" {
    description = "The availability zone to create the ELB in"
    type = list(string)
    default = ["ap-south-1"]
}

variable "timeout" {
    description = "The timeout for the ELB to become ready"
    type = number
    default = 30
}
  
