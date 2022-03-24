locals {
  name       = "${replace(var.vpc_id, "/[^a-zA-Z0-9_\\-\\.]/", "")}-${var.label}"
  base_security_group = var.base_security_group != null ? var.base_security_group : data.aws_security_group.newsg.id
  ssh_security_group_rule = var.allow_ssh_from != "" ? [{
    name        = "ssh-i"
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allow_ssh_from
    }, /*{
    name        = "ssh-internal"
    type        = "ingress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
#    cidr_blocks = cidrsubnet(data.aws_vpc.swe_vpc.cidr_block, 4, 1)
     cidr_blocks = var.cidr_block
    },*/ {
    name        = "all-e"
    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allow_ssh_from
  }] : []
  security_group_rules = concat(local.ssh_security_group_rule, var.security_group_rules)
  #  base_acl_group       = var.base_acl_group != null ? var.base_acl_group : data.aws_network_acls.newacl.id
  
}

data "aws_vpc" "swe_vpc" {
  id = var.vpc_id
}

output "ciders" {
  value = data.aws_vpc.swe_vpc.cidr_block
}

resource "aws_security_group" "vpnsg" {
  name   = "${var.name_prefix}-inst-sg-group"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-inst-sg-group"
  }
}




data "aws_security_group" "newsg" {
  id = aws_security_group.vpnsg.id
}


/*

data "aws_network_acls" "ec2acl" {
#  ids = var.defacl_id
   vpc_id     = var.vpc_id
}
*/

resource "aws_security_group_rule" "addSGrule" {

  count             = length(local.security_group_rules)
  security_group_id = local.base_security_group
  type              = local.security_group_rules[count.index]["type"]
  from_port         = lookup(local.security_group_rules[count.index], "from_port", null)
  to_port           = lookup(local.security_group_rules[count.index], "to_port", null)
  protocol          = lookup(local.security_group_rules[count.index], "protocol", null)
  cidr_blocks       = lookup(local.security_group_rules[count.index], "cidr_blocks", null)
  #  ip_version        = lookup(local.security_group_rules[count.index], "ip_version", null)
}

