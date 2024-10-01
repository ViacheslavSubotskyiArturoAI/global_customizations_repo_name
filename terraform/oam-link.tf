locals {
  oam_link_enabled      = true
  oam_sink_arn          = "arn:aws:oam:us-east-1:897722673779:sink/177205d6-3266-4809-9fd9-2182aad64efc"
  oam_sink_account_id   = split(":",local.oam_sink_arn)[4]
  is_monitoring_account = data.aws_caller_identity.this.account_id == local.oam_sink_account_id ? true : false
}

resource "aws_oam_link" "this" {
  count = local.oam_link_enabled && !local.is_monitoring_account ? 1 : 0

  sink_identifier = local.oam_sink_arn
  label_template  = "$AccountName"
  resource_types  = ["AWS::Logs::LogGroup"]
}

output "oam_link_arn" {
  value = local.oam_link_enabled && !local.is_monitoring_account ? aws_oam_link.this[0].arn : "NA"
}
