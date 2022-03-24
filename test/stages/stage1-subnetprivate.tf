module "subnets_private" {
  source                          = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets"
  vpc_name                        = module.vpc.vpc_name
  gateways                        = module.nat.ngw_id
  label                           = "private"
  subnet_cidrs                    = var.subnet_private_cidrs
  availability_zones              = var.availability_zones
  map_customer_owned_ip_on_launch = false
  map_public_ip_on_launch         = false
}