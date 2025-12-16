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
  kubernetes_version = "1.34"

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
      ami_type       = "AL2023_x86_64_STANDARD"
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


# # ALB for Ingress
# module "alb" {
#   source = "terraform-aws-modules/alb/aws"

#   name     = local.resource_name
#   internal = false
#   vpc_id   = module.vpc.vpc_id
#   subnets  = module.vpc.public_subnet_ids

#   create_security_group = false
#   security_groups       = [module.ingress_alb_sg.id]

#   enable_deletion_protection = false

#   tags = merge(
#     local.common_tags,
#     { Name = local.resource_name },
#     var.tags
#   )
# }

# resource "aws_lb_listener" "main" {
#   load_balancer_arn = module.main.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type = "fixed-response"

#     fixed_response {
#       content_type = "text/html"
#       message_body = "<h1>I'am ingress ALB</h1>"
#       status_code  = "200"
#     }
#   }
# }

# resource "aws_lb_target_group" "expense" {
#   name        = local.resource_name
#   port        = 8080
#   protocol    = "HTTP"
#   vpc_id      = module.vpc.vpc_id
#   target_type = "ip"

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     interval            = 5
#     matcher             = "200-299"
#     path                = "/"
#     port                = 8080
#     protocol            = "HTTP"
#     timeout             = 4
#   }
# }

# resource "aws_lb_listener_rule" "frontend" {
#   listener_arn = aws_lb_listener.main.arn
#   priority     = 100

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.expense.arn
#   }

#   condition {
#     host_header {
#       values = ["${local.resource_name}.${local.zone_name}"]
#     }
#   }
# }