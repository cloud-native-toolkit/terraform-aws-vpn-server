output "vpn_server" {
  description = "The arn of acm certificate server"
  value       = aws_acm_certificate.vpn_server.id
}

output "vpn_client" {
  description = "The arn of acm certificate client"
  value       = aws_acm_certificate.vpn_client_root.arn
}

output "security_group_name" {
  description = "The name of the security group"
  value = aws_security_group.vpn_sg.*.name   
}
output "security_group_id" {
  description = "The ID of the security group"
  value = aws_security_group.vpn_sg.*.id
}