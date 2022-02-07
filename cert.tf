resource "aws_acm_certificate" "vpn_server" {
 
  private_key = file("${path.cwd}/certs/vpndemo.com.key")
  certificate_body = file("${path.cwd}/certs/vpndemo.com.crt")
  certificate_chain = file("${path.cwd}/certs/ca.crt")

  tags = var.tags
}

resource "aws_acm_certificate" "vpn_client_root" {
  private_key =  file("${path.module}/certs/user.vpndemo.com.key")
  certificate_body = file("${path.cwd}/certs/user.vpndemo.com.crt")
  certificate_chain = file("${path.cwd}/certs/ca.crt")

  tags = var.tags
}