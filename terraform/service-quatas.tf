resource "aws_servicequotas_service_quota" "vpc_per_region" {
  quota_code   = "L-F678F1CE"
  service_code = "vpc"
  value        = 75
}
