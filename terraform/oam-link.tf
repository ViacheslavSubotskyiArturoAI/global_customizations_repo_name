locals {
  oam_sink_account_id = "897722673779"
  oam_sink_arn = "arn:aws:oam:us-east-1:897722673779:sink/177205d6-3266-4809-9fd9-2182aad64efc"
  is_monitoring_account = data.aws_caller_identity.this.account_id == local.oam_sink_account_id ? true : false
}

resource "aws_oam_link" "this" {
  count = local.is_monitoring_account ? 0 : 1

  sink_identifier = local.oam_sink_arn
  label_template  = "$AccountName"
  resource_types  = ["AWS::Logs::LogGroup"]
}

output "oam_sink_arn" {
  value = local.is_monitoring_account ? "NA" : aws_oam_link.this[0].arn
}
