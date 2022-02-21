variable "region" {
  type = string
  description = "The deployment region"
  default = "ap-south-1"
}
variable "access_key" {
  description = "The deployment access_key"
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

variable "nuber_subnets" {
   description = "list if subnets to attch with vpn."
   default = 1
}

variable "tags" {
   type = map(string)
   description = "Product tag"
   default =  {product = "swe", environment = "nonprod-cloud", Name = "AWS-demo-vpnclient"}
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
  //default = "vpn-swe"
  description = "Name of instance to create"
}

variable "sg_ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default = [ {
      cidr_block = "172.61.0.0/16"
      description = "connect to vpn client"
      from_port = 443
      protocol = "tcp"
      to_port = 443
    } ]
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

variable "private_subnet_tags" {
  description = "Tags for private subnets"
  type        = map(string)
  default = {
    tier = "private"
  }
}