module "nat" {
  source                          = "github.com/cloud-native-toolkit/terraform-aws-nat-gateway"
  subnet_ids                        = module.subnets_private.subnet_ids
}