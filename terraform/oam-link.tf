locals {
  oam_link_enabled = true
  oam_sink_arn     = "arn:aws:oam:us-east-1:897722673779:sink/177205d6-3266-4809-9fd9-2182aad64efc"
  oam_link_excluded_accounts_ids = [
    "676206942355", # AFT-Management
#    "741448943971", # Audit
#    "149536487885", # Log Archive
#    "692859920284", # Identity
  ]

  oam_sink_account_id   = split(":", local.oam_sink_arn)[4]
  is_monitoring_account = data.aws_caller_identity.this.account_id == local.oam_sink_account_id ? true : false
  oam_link_excluded     = local.is_monitoring_account || contains(local.oam_link_excluded_accounts_ids, data.aws_caller_identity.this.account_id) ? true : false
}

resource "aws_oam_link" "this" {
  count = local.oam_link_enabled && !local.oam_link_excluded ? 1 : 0

  sink_identifier = local.oam_sink_arn
  label_template  = "$AccountName"
  resource_types  = ["AWS::Logs::LogGroup"]
}

output "oam_link_arn" {
  value = local.oam_link_enabled && !local.oam_link_excluded ? aws_oam_link.this[0].arn : null
}
