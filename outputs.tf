output "vpn_server" {
  description = "The arn of acm certificate server"
  value       = aws_acm_certificate.vpn_server.id
}

output "vpn_client" {
  description = "The arn of acm certificate client"
  value       = aws_acm_certificate.vpn_client_root.arn
}

output "sec_id" {
  value = aws_security_group.vpnsg.*.id 
}

output "vpn_endpoint_id" {
  depends_on = [aws_ec2_client_vpn_network_association.default]
 
  value = aws_ec2_client_vpn_endpoint.default[0].id
}
