variable "instance_type" {
  type = map(string)
  default = {
    default     = "t2.micro"
    development = "t2.nano"
    staging     = "t2.small"
    production  = "t2.large"
  }
}