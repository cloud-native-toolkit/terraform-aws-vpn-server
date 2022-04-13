locals {
  sg_resource_group_name = var.resource_group_name != "" && var.resource_group_name != null ? var.resource_group_name : "default"
  sg_prefix     = var.name_prefix != "" && var.name_prefix != null ? var.name_prefix : local.resource_group_name
  sg_name        = var.name_vpn != "" ? var.name_vpn : "${local.name_prefix}"
}

resource "aws_security_group" "default" {
  count       = var.security_group_id == "" ? 1 : 0
  name_prefix = "${local.vpn_name}-Client-VPN"
  description = "security group allowing egress for client-vpn users"
  vpc_id      = var.vpc_id

  tags = {
    Name               = "${local.sg_name}-Client-VPN"
    Service            = "client-vpn"
  }
}

resource "aws_security_group_rule" "default_egress_world" {
  count             = var.security_group_id == "" ? 1 : 0
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default[0].id
}

data "aws_security_group" "newsg" {
  id = aws_security_group.default[0].id
}