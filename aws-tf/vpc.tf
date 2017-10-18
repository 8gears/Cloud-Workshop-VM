module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "workshop"
  cidr = "10.0.0.0/16"
  
  azs             = ["eu-central-1a"]
  public_subnets  = ["10.0.10.0/24"]

  enable_dns_hostnames = true
  enable_dns_support = true
  
  enable_nat_gateway = true

  enable_s3_endpoint = false

  tags = {
    Terraform = "true"
    Environment = "${var.tag_environment}"
  }
}
