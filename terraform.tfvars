client_cidr_block           = ""
rule                        = ["", ""]
route                       = [""]
active_directory_id         = ""
name                        = "AWS-demo-vpnclient"
vpc_id                      = ""
cloudwatch_log_group        = "client_vpn_endpoint"
region                      = "ap-south-1"
subnets_id                  = [""]
tags                        = {product = "ent-cloud",environment = "nonprod-cloud",techops-system = "vpnclient", Name = "AWS-demo-vpnclient"}
sg_ingress_rules = [
        {
          from_port   = 433
          to_port     = 433
          protocol    = "tcp"
          cidr_block  = ""
          description = "Redis Connection from TELX"
        }
    ]
