module "vpc" {#edge
  source    = "github.com/cloud-native-toolkit/terraform-aws-vpc"
  provision = var.provision

  /* Input params required to provision new VPC */
  name_prefix            = var.name_prefix
  internal_cidr          = var.internal_cidr_edge
  instance_tenancy       = var.instance_tenancy
}

module "vpc_dev" { #work
  source    = "github.com/cloud-native-toolkit/terraform-aws-vpc"
  provision = var.provision
 
  /* Input params required to provision new VPC */
  name_prefix            = var.name_prefix_dev
  internal_cidr          = var.internal_cidr_dev
  instance_tenancy       = var.instance_tenancy
}