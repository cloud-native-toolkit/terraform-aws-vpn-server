module "dev_vpn" {
source    = "./module"
depends_on                  = [module.subnets]
client_cidr_block           = var.client_cidr_block
allowed_cidr_ranges         = [var.internal_cidr]
//route                       = var.route
//active_directory_id         = ""
name                        = var.name
name_prefix                 = var.name_prefix
vpc_id                      = module.vpc.vpc_id
/*cloudwatch_log_group        = "client_vpn_endpoint"*/
region                      = var.region
subnet_ids                 = module.subnets_private.subnet_ids
number_subnets             = var.number_subnets
logs_retention             = var.logs_retention
}