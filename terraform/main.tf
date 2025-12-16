# VPC
module "vpc" {
  source = "./terraform-vpc-module"

  project        = var.project
  environment    = var.environment
  vpc_cidr_block = var.vpc_cidr
  subnet_cidrs   = var.subnet_cidrs
}

# Security Groups
module "node_sg" {
  source = "./terraform-sg-module"

  project     = var.project
  environment = var.environment
  instance    = "node-group"
  vpc_id      = module.vpc.vpc_id
}

module "control_plane_sg" {
  source = "./terraform-sg-module"

  project     = var.project
  environment = var.environment
  instance    = "control-plane"
  vpc_id      = module.vpc.vpc_id
}

module "ingress_alb_sg" {
  source = "./terraform-sg-module"

  project     = var.project
  environment = var.environment
  instance    = "ingress-alb"
  vpc_id      = module.vpc.vpc_id
}

# EKS Cluster
resource "aws_key_pair" "eks" {
  key_name   = "eks"
  public_key = var.public_key
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "21.0"

  name               = local.resource_name
  kubernetes_version = "1.33"

  endpoint_public_access = true

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids

  control_plane_subnet_ids = module.vpc.private_subnet_ids

  create_security_group = false
  additional_security_group_ids   = [ module.control_plane_sg.id ]

  create_node_security_group = false
  node_security_group_id     = module.node_sg.id

  eks_managed_node_groups = {
    # blue = {
    #   instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
    #   max_size      = 10
    #   min_size      = 2
    #   desired_size  = 2
    #   capacity_type = "SPOT"
    #   iam_role_additional_policies = {
    #     AmazonEBSCSIDriverPolicy       = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    #     AmazonEFSCSIDriverPolicy       = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
    #     ElasticLoadBalancingFullAccess = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
    #   }
    #   key_name = resource.aws_key_pair.eks.key_name
    # }

    green = {
      instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
      max_size      = 10
      min_size      = 2
      desired_size  = 2
    #   capacity_type = "SPOT"
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy       = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonEFSCSIDriverPolicy       = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        ElasticLoadBalancingFullAccess = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
      }
      key_name = resource.aws_key_pair.eks.key_name
    }
  }

  enable_cluster_creator_admin_permissions = true

  tags = merge(
    local.common_tags,
    { Name = local.resource_name },
    var.tags
  )
}