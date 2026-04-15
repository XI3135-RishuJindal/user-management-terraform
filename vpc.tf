module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "user-mgmt-vpc-dev"
  cidr = var.vpc_cidr

  azs             = ["us-east-1a"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}