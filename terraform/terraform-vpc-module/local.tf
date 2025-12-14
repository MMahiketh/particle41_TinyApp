locals {

  # common locals
  resource_name = "${var.project}-${var.environment}"

  module_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "true"
  }

  # Availability zones  
  all_azs_names      = data.aws_availability_zones.all_azs.names
  selected_az1       = local.all_azs_names[var.select_azs[0]]
  selected_az2       = local.all_azs_names[var.select_azs[1]]
  selected_azs_names = [local.selected_az1, local.selected_az2]
}