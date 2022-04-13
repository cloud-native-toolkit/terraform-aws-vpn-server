locals {

  resource_group_name = var.resource_group_name != "" && var.resource_group_name != null ? var.resource_group_name : "default"
  name_prefix     = var.name_prefix != "" && var.name_prefix != null ? var.name_prefix : local.resource_group_name
  vpn_name        = var.name_vpn != "" ? var.name_vpn : "${local.name_prefix}"
  #subnetid = length(var.subnet_ids) > 1 ? var.subnet_ids : [""] 
}

resource "aws_ec2_client_vpn_endpoint" "default" {
  description            = "${local.vpn_name}-Client-VPN"
  server_certificate_arn = aws_acm_certificate.vpn_server.arn
  client_cidr_block      = var.client_cidr_block
  split_tunnel           = var.split_tunnel
  dns_servers            = var.dns_servers

  authentication_options {
    type                       = var.authentication_type
    root_certificate_chain_arn = var.authentication_type != "certificate-authentication" ? null : aws_acm_certificate.vpn_client_root.arn
    saml_provider_arn          = var.authentication_saml_provider_arn
  }
  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }
  tags =   {
    Name          = local.vpn_name
    ResourceGroup = local.resource_group_name
    Service       = "client-vpn"
  }
}

resource "aws_ec2_client_vpn_network_association" "default" {
  count                  = var.number_subnets_vpn
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  subnet_id              = element(var.subnet_ids, count.index)
  security_groups        = [var.security_group_id == "" ? aws_security_group.default[0].id : var.security_group_id]
}

# resource "time_sleep" "wait" {
#   depends_on = [aws_ec2_client_vpn_network_association.default]
#   create_duration = "30s"
# }

resource "aws_ec2_client_vpn_authorization_rule" "all_groups" {
  count                  = length(var.allowed_cidr_ranges)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  target_network_cidr    = var.allowed_cidr_ranges[count.index]
  authorize_all_groups   = true
  description = "autorization rule for cider range - ${var.allowed_cidr_ranges[count.index]}"
}


resource "aws_ec2_client_vpn_route" "vpn_route" { 
  depends_on = [
    aws_ec2_client_vpn_network_association.default
  ]
  for_each               = {for index, pair in setproduct(var.additional_routes, var.route_subnet_ids) : index => pair }
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  destination_cidr_block = each.value[0]
  target_vpc_subnet_id   = each.value[1]
}