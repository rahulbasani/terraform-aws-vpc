# terraform-aws-vpc
AWS VPC Module Using Terraform

This module helps to create aws vpc resources.

Usage

![image](https://github.com/rahulbasani/terraform-aws-vpc/assets/59694236/eba7f59f-fc95-48e5-b069-f6727e2c12de)


By default this module will provision an internet gateway associated with vpc if there is atleast one public subnet created. And for each private subnet created a route table associated with the subnet is created.

Note: In the example we have created 2 public subnets and one private subnets. you can create as many subnets as you need.
