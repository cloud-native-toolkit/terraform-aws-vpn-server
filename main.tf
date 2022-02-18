locals {
  subnets_ids  = length(var.subnets_ids)

}

resource "aws_cloudwatch_log_group" "vpnlog" {
  name = "vpn-log"

  tags = var.tags
  
}
resource "aws_ec2_client_vpn_endpoint" "vpn" {
  description = "Client VPN nonprod"
  client_cidr_block = var.client_cidr_block
  split_tunnel = true

  transport_protocol  = "tcp"
  
  server_certificate_arn = aws_acm_certificate.vpn_server.arn

  authentication_options {
    type = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.vpn_client_root.arn
  }

  /*authentication_options {
    type = "directory-service-authentication"
    active_directory_id = var.active_directory_id
  }
*/
  connection_log_options {
    enabled = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpnlog.name

  }

  tags = var.tags
}


resource "aws_ec2_client_vpn_network_association" "vpn_subnets" {
  //count   = (local.subnets_ids > 0) ? local.subnets_ids : 0
  count = var.nuber_subnets
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  subnet_id = element(var.subnets_ids, count.index)
  security_groups = [aws_security_group.vpn_sg.id]

  //lifecycle {
    // The issue why we are ignoring changes is that on every change
    // terraform screws up most of the vpn assosciations
    // see: https://github.com/hashicorp/terraform-provider-aws/issues/14717
    //ignore_changes = [subnet_id]
  //}
}