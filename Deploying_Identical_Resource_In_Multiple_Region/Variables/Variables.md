# ***<ins>Variables in Terraform </ins>***

Here is how a variable is declared in terraform. A seperate file needs to be created by the name variables.tf and each variables needs to be documented as shown below. If a variable file is given any other name apart from variables.tf then when executing the configuration file we need to mention the name of the variable file. 
```terraform
variable "nouns" {
  description = "A list of nouns"
  type        = list(string)
}
 
variable "adjectives" {
  description = "A list of adjectives"
  type        = list(string)
}
 
variable "verbs" {
  description = "A list of verbs"
  type        = list(string)
}
 
variable "adverbs" {
  description = "A list of adverbs"
  type        = list(string)
}
 
variable "numbers" {
  description = "A list of numbers"
  type        = list(number)
}
```

Not instead of definining such a long list of variables we can use the below mentioned trick by declaring the variables in the below mentioned way in the main.tf configuration file.

```terraform
terraform {                                             
  required_version = ">= 0.15"
}
 
variable "words" {
  description = "A word pool to use for Mad Libs"
  type = object({                                       
    nouns      = list(string),
    adjectives = list(string),
    verbs      = list(string),
    adverbs    = list(string),
    numbers    = list(number),
  })
}
```
### ***<ins>Validating Variables</ins>***
Input variables can be validated with custom rules by declaring a nested validation block. To validate that at least 20 nouns are passed into var.words, you can write a validation block:
```terraform
variable "words" {
  description = "A word pool to use for Mad Libs"
  type = object({
    nouns      = list(string),
    adjectives = list(string),
    verbs      = list(string),
    adverbs    = list(string),
    numbers    = list(number),
  })
 
  validation {
    condition     = length(var.words["nouns"]) >= 20
    error_message = "At least 20 nouns must be supplied."
  }
}
```
The condition argument in validation is an expression that determines whether a variable is valid. true means it’s valid, while false means invalid. Invalid expressions will exit with an error, and the error message error_message will be displayed to the user.
There is no limit to the number of validation blocks you can have on a variable, allowing you to be as fine-grained with validation as you like.