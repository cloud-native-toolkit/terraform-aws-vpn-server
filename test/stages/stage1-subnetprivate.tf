module "subnets_private" {
  source                          = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets"
  vpc_name                        = module.vpc.vpc_name
  gateways                        = module.nat.ngw_id
  label                           = "private"
  subnet_cidrs                    = var.subnet_private_cidrs
  availability_zones              = var.availability_zones_dev
  map_customer_owned_ip_on_launch = false
  map_public_ip_on_launch         = false
}

module "subnets_private_dev" {
  source                          = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets"
  vpc_name                        = module.vpc_dev.vpc_name
  gateways                        = module.nat_dev.ngw_id
  label                           = "private"
  subnet_cidrs                    = var.subnet_private_cidrs_dev
  availability_zones              = var.availability_zones_dev
  map_customer_owned_ip_on_launch = false
  map_public_ip_on_launch         = false
}