locals {
  resource_name = "${var.project}-${var.environment}"
  network = ["public", "private"]
  # subnet_ids = split(",", data.aws_ssm_parameter.subnet_ids.value)

  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "true"
  }
}