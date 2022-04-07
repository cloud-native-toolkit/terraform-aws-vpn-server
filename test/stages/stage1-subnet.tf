module "subnets" {
  source                          = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets"
  vpc_name                        = module.vpc.vpc_name
  gateways                        = [module.gateway.igw_id]
  label                           = "public"
  subnet_cidrs                    = var.public_subnet_cidr
  availability_zones              = var.availability_zones
  map_customer_owned_ip_on_launch = false
  map_public_ip_on_launch         = false
}