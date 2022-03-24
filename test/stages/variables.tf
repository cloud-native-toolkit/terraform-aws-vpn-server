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
  default     = "swe-vpn"
}
variable "subnets_ids" {
  type = list(string)
  description = "subnet_id"
  //default = ["subnet-06d0a8066ed3e64d1"]
  default = [""]
}
variable "allow_ssh_from" {
  type        = list(any)
  description = "An IP address, a CIDR block, or a single security group identifier to allow incoming SSH connection to the virtual server"
  default     = ["0.0.0.0/0"]
  #   default     = []
}

variable "nuber_subnets" {
   description = "list if subnets to attch with vpn"
   type = number
   default = 1
}

/*variable "tags" {
   type = map(string)
   description = "Product tag"
   default =  {product = "swe", environment = "nonprod-cloud", Name = "AWS-demo-vpnclient"}
}*/

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
   default = "172.61.0.0/16"
}

variable "rule" {
   type = list(string)
   description = "vpn rule rule"
   default     = ["172.61.0.0/16", "10.0.0.0/16"]
}

/*variable "route" {
   type = list(string)
   description = "vpn rout rule"
   default     = ["172.31.0.0/16"]
}*/

variable "name" {
  type = string
  default = "vpn-swe"
  description = "Name of instance to create"
}
variable "name_vpn" {
  type = string
  default = ""
  description = "Name of instance to create"
}

variable "security_group_rules" {
  type = list(object({
    name        = string,
    type        = string,
    protocol    = string,
    from_port   = number,
    to_port     = number,
    cidr_blocks = optional(string),
    ip_version  = optional(string),
  }))
  description = "List of security group rules to set on the bastion security group in addition to the SSH rules"
  default     = []
}


###var used by VPC Module ###start

variable "provision" {
  type        = bool
  description = "Flag indicating that the instance should be provisioned. If false then an existing instance will be looked up"
  default     = true
}

variable "internal_cidr" {
  type        = string
  description = "The cidr range of the internal network.Either provide manually or chose from AWS IPAM poolsß"
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
  type        = string
  description = "Instance is shared / dedicated, etc. #[default, dedicated, host]"
  default     = "default"
}



###var used by Subenet Module ###start


variable "private_subnet_cidr" {
  type        = list(string)
  description = "(Required) The CIDR block for the private subnet."
  default     = ["10.0.125.0/24"]
}

variable "public_subnet_cidr" {
  type        = list(string)
  description = "(Required) The CIDR block for the public subnet."
  default     = ["10.0.0.0/20"]
}

variable "availability_zones" {
  description = "List of availability zone ids"
  type        = list(string)
  default     = ["ap-south-1a"]
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
variable "subnet_cidrs" {
  type        = list(string)
  description = "(Required) The CIDR block for the  subnet."
  default     = ["10.0.0.0/20"]
}
variable "subnet_private_cidrs" {
  type        = list(string)
  description = "(Required) The CIDR block for the  subnet."
  default     = ["10.0.125.0/24"]
}
variable "private_subnet_tags" {
  description = "Tags for private subnets"
  type        = map(string)
  default = {
    tier = "private"
  }
}