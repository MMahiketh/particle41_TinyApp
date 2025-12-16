resource "aws_security_group" "main" {
  name        = local.resource_name
  description = "Security group for ${var.instance}"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.module_tags,
    { Name = local.resource_name },
    var.sg_tags
  )
}