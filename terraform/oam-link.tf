resource "aws_oam_link" "oam_source_link" {
  sink_identifier = "arn:aws:oam:us-east-1:897722673779:sink/177205d6-3266-4809-9fd9-2182aad64efc"
  label_template  = "$AccountName"
  resource_types  = ["AWS::Logs::LogGroup"]
}
