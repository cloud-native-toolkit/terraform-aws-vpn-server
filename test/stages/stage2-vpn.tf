module "dev_vpn" {
source    = "./module"
depends_on                  = [module.subnets]
client_cidr_block           = var.client_cidr_block
allowed_cidr_ranges         = [var.internal_cidr_edge, var.internal_cidr_dev]
name                        = var.name
name_prefix                 = var.name_prefix
vpc_id                      = module.vpc.vpc_id
region                      = var.region_vpn
subnet_ids                  = module.subnets_private.subnet_ids
dns_servers                 = var.dns_servers
number_subnets_association  = length(var.subnet_private_cidrs)
additional_routes           =  ["10.1.0.0/16", "10.2.0.0/16"] 
#number_additional_routes    = 4      
}