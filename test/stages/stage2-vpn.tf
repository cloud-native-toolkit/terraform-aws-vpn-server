module "dev_vpn" {
source    = "./module"
depends_on                  = [module.subnets]
client_cidr_block           = var.client_cidr_block
rule                        = var.rule
//route                       = var.route
//active_directory_id         = ""
name                        = var.name
vpc_id                      = module.vpc.vpc_id
/*cloudwatch_log_group        = "client_vpn_endpoint"*/
region                      = var.region
subnets_ids                 = module.subnets.subnet_ids
tags                        = var.tags
sg_ingress_rules            = var.sg_ingress_rules
nuber_subnets               = var.nuber_subnets

}