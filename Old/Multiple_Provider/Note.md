# Multiple Providers
We can create the same resource in multiple regions by using the multiple provider method.
In the main.tf file we've declared 2 VPC resource.
Make a note of the suttle difference it has which is in the second provider we've added a meta argument called ALIAS. 
The same alias is called as the argument value to provider in the file VPC_Create2.tf.