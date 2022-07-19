locals {
  resource_group_vpn_name   = var.resource_group_name != "" && var.resource_group_name != null ? var.resource_group_name : "default"
  vpn_name_prefix           = var.name_prefix != "" && var.name_prefix != null ? var.name_prefix : local.resource_group_vpn_name
  log_name                  = var.log_group_name != "" ? var.log_group_name : "${local.vpn_name_prefix}"
}
resource "aws_cloudwatch_log_group" "vpn" {
  name              = "/aws/vpn/${local.log_name}/logs"
  retention_in_days = var.logs_retention

}

resource "aws_cloudwatch_log_stream" "vpn" {
  name           = "vpn-usage"
  log_group_name = aws_cloudwatch_log_group.vpn.name
}