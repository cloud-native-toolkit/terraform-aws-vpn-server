
resource "aws_ec2_client_vpn_authorization_rule" "vpn_auth_rule" {
  count   = length(var.rule)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr = element(var.rule, count.index)
  authorize_all_groups = true
}

/*resource "aws_ec2_client_vpn_route" "vpn_route" {
  count = length(var.route)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  destination_cidr_block = element(var.route, count.index)
  target_vpc_subnet_id   = element(var.subnets_ids, count.index)
}*/