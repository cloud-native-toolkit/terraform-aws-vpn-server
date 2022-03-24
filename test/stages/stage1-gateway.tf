module "gateway" {
  source                          = "github.com/cloud-native-toolkit/terraform-aws-vpc-gateways"
  vpc_name                        = module.vpc.vpc_name
}