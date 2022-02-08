variable "region" {
  description = "The deployment region"
}

///variable "assume-role" {
   // type = string
    //description = "Assume Role to deploy on remote aws account"
//}

variable "subnets_id" {
  description = "subnet_id"
}


variable "tags" {
   description = "Product tag"
}

variable "vpc_id" {
   description = "vpc id"
}

variable "active_directory_id" {
   description = "aws active directory connect id"
}

variable "cloudwatch_log_group" {
   description = "aws cloudwatch_log_group id"
}

variable "client_cidr_block" {
   description = "client cidr block"
}

variable "rule" {
   description = "vpn rule rule"
}


variable "route" {
   description = "vpn rout rule"
}

variable "name" {
  type = string
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
}