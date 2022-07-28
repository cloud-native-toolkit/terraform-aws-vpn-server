variable "region" {
  type = string
  description = "The deployment region"
  default = ""
}

variable "subnet_ids" {
  type = list(string)
  description = "Subnet ID to associate clients (each subnet passed will create an VPN association -costs involved)"
  default = []
}

variable "additional_routes" {
  type        = list(string)
  default     = []
  description = "List of additonal routes to add in VPN"
}

variable "number_additional_routes" {
  type        = number
  default     = 0
  description = "cont of additonal routes to add in VPN"
}

variable "allowed_cidr_ranges" {
   type = list(string)
   description = "List of CIDR ranges from which access is allowed."
   default     = []
}

variable "vpc_id" {
  type = string
   description = "VPC Id to create resources"
   default = ""
}

variable "create_vpn" {
  type        = bool
  default     = true
  description = "Indicates whether you want to  create vpn"
}

variable "existing_vpn_id" {
  type = string
   description = "VPC Id to create resources"
   default = ""
}
variable "security_group_id" {
  type        = string
  description = "ID of the base security group(SG) to use for the VPN services. If not provided a new SG  will be created."
  default     = ""
}

variable "ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
      {
        from_port=-1
        to_port=-1
        protocol="all"
        cidr_block="0.0.0.0/0"
        description="allow_vpn"
      }
    ]
}

variable "logs_retention" {
  default     = 365
  description = "Retention in days for CloudWatch Log Group"
}
variable "log_group_name" {
  type = string
  default = ""
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

variable "number_subnets_association" {
   description = "list of subnets to attch with vpn"
   type = number
   default = 0
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "List of DNS Servers."
}

variable "name_prefix" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = ""
}