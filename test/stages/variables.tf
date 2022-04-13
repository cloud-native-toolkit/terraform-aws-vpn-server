variable "region" {
  type = string
  description = "The deployment region"
  default = "ap-south-1"
}
variable "access_key" {
  description = "The deployment access_key."
  type = string
}
variable "secret_key" {
  type = string
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default     = "default"
}


variable "name_prefix" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = "route-vpn"
}
variable "name_prefix_dev" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = "route-vpn-dev"
}
variable "subnets_ids" {
  type = list(string)
  description = "subnet_id"
  default = [""]
}


variable "vpc_id" {
   type = string
   description = "vpc id"
   //default = "vpc-04f723f4bca6e8583"
   default = ""
}

/*variable "active_directory_id" {
   description = "aws active directory connect id"
}*/

/*variable "cloudwatch_log_group" {
   description = "aws cloudwatch_log_group id"
}*/

variable "client_cidr_block" {
  type = string
   description = "client cidr block"
   default = "172.63.0.0/16"
}
variable "authentication_type" {
  default     = "certificate-authentication"
  description = "The type of client authentication to be used. Specify certificate-authentication to use certificate-based authentication, directory-service-authentication to use Active Directory authentication, or federated-authentication to use Federated Authentication via SAML 2.0."
}
variable "split_tunnel" {
  default     = true
  description = "With split_tunnel false, all client traffic will go through the VPN."
}


variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "List of DNS Servers"
}

variable "authentication_saml_provider_arn" {
  default     = null
  description = "(Optional) The ARN of the IAM SAML identity provider if type is federated-authentication."
}
variable "allowed_cidr_ranges" {
   type = list(string)
   description = "List of CIDR ranges from which access is allowed"
   default     = [""]
}

/*variable "route" {
   type = list(string)
   description = "vpn rout rule"
   default     = ["172.31.0.0/16"]
}*/

variable "name" {
  type = string
  default = "vpn-swe"
  description = "Name of log gruop to create"
}
variable "name_vpn" {
  type = string
  default = ""
  description = "Name of instance to create"
}
variable "logs_retention" {
  default     = 365
  description = "Retention in days for CloudWatch Log Group"
}

###var used by VPC Module ###start

variable "provision" {
  type        = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default     = true
}
variable "vpn_endpoint_id" {
  type        = string
  description = "The id of client vpn."
  default     = ""
}
variable "number_subnets_vpn" {
   description = "list of subnets to attch with vpn"
   type = number
   default = 0
}

variable "vpn_subnets_id" {
  type        = list(string)
 description = "The list of subnet id which are associated with vpn."
  default     = []
}
variable "internal_cidr_pub" {
  type        = string
  description = "The cidr range of the internal network.Either provide manually or chose from AWS IPAM poolsß"
  default     = "10.10.0.0/16"
}

variable "internal_cidr_dev" {
  type        = string
  description = "The cidr range of the internal network.Either provide manually or chose from AWS IPAM poolsß"
  default     = "10.20.0.0/16"
}

variable "instance_tenancy" {
  type        = string
  description = "Instance is shared / dedicated, etc. #[default, dedicated, host]"
  default     = "default"
}



###var used by Subenet Module ###start

variable "public_subnet_cidr_pub" {
  type        = list(string)
  description = "(Required) The CIDR block for the public subnet."
  default     = ["10.10.3.0/24"]
}

variable "availability_zones_dev" {
  description = "List of availability zone ids"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}



variable "public_subnet_tags" {
  description = "Tags for public subnets"
  type        = map(string)
  default = {
    tier = "public"
  }
}

variable "label" {
  type        = string
  description = "The label for the server instance"
  default     = "server"
}

variable "base_security_group" {
  type        = string
  description = "ID of the base security group(SG) to use for the ec2 instance. If not provided a new SG  will be created."
  default     = null
}
variable "subnet_private_cidrs" {
  type        = list(string)
  description = "(Required) The CIDR block for the  subnet."
  default     = ["10.10.0.0/24", "10.10.1.0/24"]
}

variable "subnet_private_cidrs_dev" {
  type        = list(string)
  description = "(Required) The CIDR block for the  subnet."
  default     = ["10.20.10.0/24", "10.20.20.0/24"]
}
variable "private_subnet_tags" {
  description = "Tags for private subnets"
  type        = map(string)
  default = {
    tier = "private"
  }
}
