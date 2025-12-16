resource "aws_security_group_rule" "control_plane_node" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.control_plane_sg.id
  security_group_id        = module.node_sg.id
}

resource "aws_security_group_rule" "node_control_plane" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.node_sg.id
  security_group_id        = module.control_plane_sg.id
}

resource "aws_security_group_rule" "node_node" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.node_sg.id
  security_group_id        = module.node_sg.id
}


resource "aws_security_group_rule" "ingress_alb_node" {
  type                     = "ingress"
  from_port                = var.nodeport_start
  to_port                  = var.nodeport_end
  protocol                 = "tcp"
  source_security_group_id = module.ingress_alb_sg.id
  security_group_id        = module.node_sg.id
}

resource "aws_security_group_rule" "internet_ingress_alb" {
  type              = "ingress"
  from_port         = var.http_port
  to_port           = var.http_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.ingress_alb_sg.id
}