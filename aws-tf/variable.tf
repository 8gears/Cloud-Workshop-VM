#
# Defines all variables that are used with defaults.
# Default values can be overriden in the terraform.tfvars and *.env.tfvars files.
#
variable "workshop_user" {
   description = "The default Workshop User."
   default = "oiz"
}

variable "workshop_user_password" {
   description = "The default Workshop User password."
}

variable "tag_environment" {
  description = "The Environment TAG"
  default = "WS"
}

variable "key_pair_public_key" {
  description = "In order to access an EC2 instance once it is created, you need to assign an AWS EC2 Key Pair and public key." 
}

variable "vpc_region" {    
  description = "The VPC related region" 
  default = "eu-central-1"
}

variable "vm_nodes_count" {
  default = 8
}

variable "aws_instance_type" {
   default = "t2.xlarge"
}

variable "private_key_file" {
   description = "Location of the private Key. counter part to the public key pair."
   default = "~/.ssh/id_rsa"
}


variable "aws_access_key_id" {} 
variable "aws_secret_access_key" {}
