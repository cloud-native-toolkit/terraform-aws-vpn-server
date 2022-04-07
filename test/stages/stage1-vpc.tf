module "vpc" {#edge
  source    = "github.com/cloud-native-toolkit/terraform-aws-vpc"
  provision = var.provision

  /* Input params required to provision new VPC */
  name_prefix            = var.name_prefix
  internal_cidr          = var.internal_cidr_pub
  instance_tenancy       = var.instance_tenancy
  //vpc_id           = var.vpc_id

}

module "vpc_dev" { #work
  source    = "github.com/cloud-native-toolkit/terraform-aws-vpc"
  provision = var.provision
 
  /* Input params required to provision new VPC */
  name_prefix            = var.name_prefix_dev
  internal_cidr          = var.internal_cidr_dev
  instance_tenancy       = var.instance_tenancy
  # number_subnets_vpn     = length(var.subnet_private_cidrs_dev)
  # vpn_endpoint_id        = module.dev_vpn.vpn_endpoint_id
  # vpn_subnets_id         = module.subnets_private.subnet_ids
  # //vpc_id           = var.vpc_id

}