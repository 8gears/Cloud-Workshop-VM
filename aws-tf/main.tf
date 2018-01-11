provider "aws" {
   region = "${var.vpc_region}"
   version = "~> 1.6.0"
   access_key = "${var.aws_access_key_id}"
   secret_key = "${var.aws_secret_access_key}"
}

# terraform {
#   backend "s3" {
#     bucket = "workshop-terraform-state"
#     key    = "oiz" 
#     region = "eu-central-1"
#   }
# }

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
