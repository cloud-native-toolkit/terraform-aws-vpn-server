locals {
  sg_resource_group_name = var.resource_group_name != "" && var.resource_group_name != null ? var.resource_group_name : "default"
  sg_prefix     = var.name_prefix != "" && var.name_prefix != null ? var.name_prefix : local.sg_resource_group_name
  sg_name        = var.name_vpn != "" ? var.name_vpn : "${local.sg_prefix}"
  base_security_group = var.security_group_id != "" && var.security_group_id != null  ? var.security_group_id : aws_security_group.vpnsg[0].id
}


resource "aws_security_group" "vpnsg" {
  count       = var.security_group_id != "" && var.security_group_id != null ? 0 : 1
  name_prefix = "${local.vpn_name}-Client-VPN"
  description = "security group allowing egress for client-vpn users"
  vpc_id      = var.vpc_id

  tags = {
    Name               = "${local.sg_name}-Client-VPN"
    Service            = "client-vpn"
  }
}

resource "aws_security_group_rule" "default_egress" {
  count             = var.security_group_id != "" && var.security_group_id != null  ? 0 : 1
  type              = "egress"
  from_port         = -1
  to_port           = -1
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.base_security_group
}
resource "aws_security_group_rule" "ingress_rules" {
  count = var.security_group_id != "" && var.security_group_id != null  ? 0 : length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = local.base_security_group
}

data "aws_security_group" "newsg" {
  id = aws_security_group.vpnsg[0].id
}