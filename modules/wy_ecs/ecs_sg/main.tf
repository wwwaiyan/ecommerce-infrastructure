locals {
  len_vpc_id        = length(var.vpc_id)
  len_sg_name       = length(var.sg_name)
  len_ingress_rules = length(var.ingress_rules)
  len_egress_rules  = length(var.egress_rules)
}
resource "aws_security_group" "sg" {
  count       = local.len_sg_name > 0 ? 1 : 0
  vpc_id      = var.vpc_id
  description = "Security Group for ${var.project_name}-${var.env_prefix}-${var.sg_name}-sg"
  name        = "${var.project_name}-${var.env_prefix}-${var.sg_name}-sg"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name        = "${var.project_name}-${var.env_prefix}-${var.sg_name}-sg"
    Project     = var.project_name
    Environment = var.env_prefix
  }
}
resource "aws_security_group_rule" "ingress_rules" {
  count = local.len_sg_name > 0 && local.len_ingress_rules > 0 ? local.len_ingress_rules : 0

  security_group_id = aws_security_group.sg[0].id
  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_blocks]
  description       = var.ingress_rules[count.index].description
}

resource "aws_security_group_rule" "egress_rules" {
  count = local.len_sg_name > 0 && local.len_egress_rules > 0 ? local.len_egress_rules : 0

  security_group_id = aws_security_group.sg[count.index].id
  type              = "egress"
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol
  cidr_blocks       = [var.egress_rules[count.index].cidr_blocks]
  description       = var.egress_rules[count.index].description
}