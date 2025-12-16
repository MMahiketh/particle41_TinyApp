locals {

  # common locals
  resource_name = "${var.project}-${var.environment}-${var.instance}"

  module_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "true"
  }
}