module "subnets" {
  source                          = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets"
  vpc_name                        = module.vpc.vpc_name
  provision                       = var.provision
  gateways                        = [module.gateway.igw_id]
  label                           = "public"
  subnet_cidrs                    = var.public_subnet_cidr_pub
  availability_zones              = var.availability_zones_dev
  region                          = var.region_vpn
  name_prefix                     = var.name_prefix
}