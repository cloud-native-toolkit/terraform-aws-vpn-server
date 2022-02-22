# Generate the Server and Client certificates and import them into the Certificate Manager instance
resource null_resource create_certificates {                                                          

    provisioner "local-exec" {                                                                          
        command = "${path.module}/scripts/create-certificates.sh"
        working_dir = path.root
    }
}

data "local_file" "ca" {
   depends_on = [
     null_resource.create_certificates
   ]
    filename = "${path.root}/certificates/ca.crt"
}

data "local_file" "server_cert" {
   depends_on = [
     null_resource.create_certificates
   ]
    filename = "${path.root}/certificates/issued/vpn-server.vpn.ibm.com.crt"
}

data "local_file" "server_key" {
   depends_on = [
     null_resource.create_certificates
   ]
    filename = "${path.root}/certificates/private/vpn-server.vpn.ibm.com.key"
}

data "local_file" "client_cert" {
   depends_on = [
     null_resource.create_certificates
   ]
    filename = "${path.root}/certificates/issued/client1.vpn.ibm.com.crt"
}

data "local_file" "client_key" {
   depends_on = [
     null_resource.create_certificates
   ]
    filename = "${path.root}/certificates/private/client1.vpn.ibm.com.key"
}



resource "aws_acm_certificate" "vpn_server" {
 
  private_key = data.local_file.server_key.content
  certificate_body = data.local_file.server_cert.content
  certificate_chain = data.local_file.ca.content

  tags = var.tags
}

resource "aws_acm_certificate" "vpn_client_root" {
  private_key =  data.local_file.client_key.content
  certificate_body = data.local_file.client_cert.content
  certificate_chain = data.local_file.ca.content

  tags = var.tags
}