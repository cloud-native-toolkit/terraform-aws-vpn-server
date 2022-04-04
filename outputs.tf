output "vpn_server" {
  description = "The arn of acm certificate server"
  value       = aws_acm_certificate.vpn_server.id
}

output "vpn_client" {
  description = "The arn of acm certificate client"
  value       = aws_acm_certificate.vpn_client_root.arn
}

output "sec_id" {
  value = data.aws_security_group.newsg.id
}

output "vpn_endpoint_id" {
  value = aws_ec2_client_vpn_endpoint.default.id
}