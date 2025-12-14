module "vpc" {
  source = "./terraform-vpc-module"

  project        = var.project
  environment    = var.environment
  vpc_cidr_block = var.vpc_cidr
  subnet_cidrs   = var.subnet_cidrs
}