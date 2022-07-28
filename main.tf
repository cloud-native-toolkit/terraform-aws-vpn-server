locals {
  resource_group_name   = var.resource_group_name != "" && var.resource_group_name != null ? var.resource_group_name : "default"
  name_prefix           = var.name_prefix != "" && var.name_prefix != null ? var.name_prefix : local.resource_group_name
  vpn_name              = var.name_vpn != "" ? var.name_vpn : "${local.name_prefix}"
  client_vpn_id         = var.existing_vpn_id != null && var.existing_vpn_id != "" ? var.existing_vpn_id : (var.create_vpn ? aws_ec2_client_vpn_endpoint.default[0].id : null)
  route_config_provided = var.subnet_ids != null && length(var.subnet_ids) > 0
  route_config_list     = local.route_config_provided ? [for i in setproduct(var.additional_routes, var.subnet_ids) : i] : []
  number_additional_routes = length(local.route_config_list)
 }

resource "aws_ec2_client_vpn_endpoint" "default" {
  count                  = var.create_vpn ? 1 : 0
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
  count                  = var.create_vpn && var.number_subnets_association > 0 ? var.number_subnets_association : 0
  client_vpn_endpoint_id = local.client_vpn_id
  subnet_id              = element(var.subnet_ids, count.index)
}

resource "aws_ec2_client_vpn_authorization_rule" "all_groups" {
  count                  = var.create_vpn && length(var.allowed_cidr_ranges) > 0 ? length(var.allowed_cidr_ranges) : 0
  client_vpn_endpoint_id = local.client_vpn_id
  target_network_cidr    = var.allowed_cidr_ranges[count.index]
  authorize_all_groups   = true
  description = "autorization rule for cider range - ${var.allowed_cidr_ranges[count.index]}"
}


resource "aws_ec2_client_vpn_route" "vpn_route" { 
  depends_on = [
    aws_ec2_client_vpn_network_association.default
  ]
  count = var.additional_routes != "" && var.additional_routes != null  ? local.number_additional_routes : 0
  description = "route to  - ${local.route_config_list[count.index][0]} from ${local.route_config_list[count.index][1]}"
  client_vpn_endpoint_id = local.client_vpn_id
  destination_cidr_block = local.route_config_list[count.index][0]
  target_vpc_subnet_id   = local.route_config_list[count.index][1]
}

resource null_resource client_vpn_profile {   
  depends_on = [
    aws_ec2_client_vpn_network_association.default
  ]

  provisioner "local-exec" {
    command = "${path.module}/scripts/generate-vpnprofile.sh"
    working_dir = path.root
    environment = {
      VPN_SERVER = local.vpn_name
      VPN_ID     = local.client_vpn_id
      REGION     = var.region
    }
  }
}

resource null_resource "client-vpn-security-group" {
  provisioner "local-exec" {
    when    = create
    command = "aws ec2 apply-security-groups-to-client-vpn-target-network --client-vpn-endpoint-id ${local.client_vpn_id} --vpc-id ${var.vpc_id} --security-group-ids ${local.base_security_group} --region ${var.region}"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_ec2_client_vpn_endpoint.default,
    aws_security_group.vpnsg
  ]
}