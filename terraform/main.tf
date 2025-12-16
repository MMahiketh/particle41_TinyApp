# VPC
module "vpc" {
  source = "./terraform-vpc-module"

  project        = var.project
  environment    = var.environment
  vpc_cidr_block = var.vpc_cidr
  subnet_cidrs   = var.subnet_cidrs
}

# Security Groups
module "node" {
  source = "./terraform-sg-module"

  project     = var.project
  environment = var.environment
  instance    = "node-group"
  vpc_id      = module.vpc.vpc_id
}

module "control_plane" {
  source = "./terraform-sg-module"

  project     = var.project
  environment = var.environment
  instance    = "control-plane"
  vpc_id      = module.vpc.vpc_id
}

module "ingress_alb" {
  source = "./terraform-sg-module"

  project     = var.project
  environment = var.environment
  instance    = "ingress-alb"
  vpc_id      = module.vpc.vpc_id
}