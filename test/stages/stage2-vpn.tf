module "dev_vpn" {
source    = "./module"
depends_on                  = [module.subnets]
client_cidr_block           = var.client_cidr_block
allowed_cidr_ranges         = [var.internal_cidr_pub, var.internal_cidr_dev]
//route                       = var.route
//active_directory_id         = ""
name                        = var.name
name_prefix                 = var.name_prefix
vpc_id                      = module.vpc.vpc_id
/*cloudwatch_log_group        = "client_vpn_endpoint"*/
region                      = var.region
subnet_ids                 = module.subnets_private.subnet_ids
dns_servers                = var.dns_servers
number_subnets_vpn         = length(var.subnet_private_cidrs)
logs_retention             = var.logs_retention
}