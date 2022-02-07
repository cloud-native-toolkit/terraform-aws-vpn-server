client_cidr_block           = "172.61.0.0/16"
rule                        = ["172.61.0.0/16", "10.0.0.0/16"]
active_directory_id         = ""
name                        = "AWS-demo-vpnclient"
vpc_id                      = "vpc-04f723f4bca6e8583"
cloudwatch_log_group        = "client_vpn_endpoint"
region                      = "ap-south-1"
subnets_id                  = ["subnet-0a350449103177c71"]
tags                        = {product = "ent-cloud",environment = "nonprod-cloud",techops-system = "vpnclient", Name = "AWS-demo-vpnclient"}
sg_ingress_rules = [
        {
          from_port   = 433
          to_port     = 433
          protocol    = "tcp"
          cidr_block  = "172.61.0.0/16"
          description = "Redis Connection from TELX"
        }
    ]
