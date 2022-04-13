variable "region" {
  type = string
  description = "The deployment region"
  default = "ap-south-1"
}


variable "subnet_ids" {
  type = list(string)
  description = "Subnet ID to associate clients (each subnet passed will create an VPN association - costs involved)"
  default = []
}

variable "route_subnet_ids" {
  type = list(string)
  description = "Subnet ID to associate additonal route for clients (each subnet passed will create a VPN route )"
  default = []
}

variable "additional_routes" {
  type = list(string)
  description = "Subnet ID to associate additonal route for clients (each subnet passed will create a VPN route )"
  default = []
}

variable "allowed_cidr_ranges" {
   type = list(string)
   description = "List of CIDR ranges from which access is allowed"
   default     = []
}

variable "vpc_id" {
  type = string
   description = "VPC Id to create resources"
   default = ""
}

variable "security_group_id" {
  type        = string
  description = "Optional security group id to use instead of the default created"
  default     = ""
}


variable "client_cidr_block" {
   type = string
   description = "client cidr block"
   default = "172.63.0.0/16"
}

variable "logs_retention" {
  default     = 365
  description = "Retention in days for CloudWatch Log Group"
}

variable "name" {
  type = string
  default = "vpn-swe"
  description = "Name for vpn log gruop"
}

variable "name_vpn" {
  type = string
  default = ""
  description = "Name of resource  VPN to create"
}
variable "authentication_type" {
  default     = "certificate-authentication"
  description = "The type of client authentication to be used. Specify certificate-authentication to use certificate-based authentication, directory-service-authentication to use Active Directory authentication, or federated-authentication to use Federated Authentication via SAML 2.0."
}

variable "authentication_saml_provider_arn" {
  default     = null
  description = "(Optional) The ARN of the IAM SAML identity provider if type is federated-authentication."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default     = "default"
}

variable "split_tunnel" {
  default     = true
  description = "With split_tunnel false, all client traffic will go through the VPN."
}

variable "number_subnets_vpn" {
   description = "list if subnets to attch with vpn"
   type = number
   default = 0
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "List of DNS Servers"
}

variable "name_prefix" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = ""
}