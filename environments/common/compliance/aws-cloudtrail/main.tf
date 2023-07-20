provider "aws" {
  profile = "account-name"
  region  = "us-east-1"
}

locals {
  cloudtrail_enabled = true

  prefix = "canal"

  tags = {
    "Creator" = "opsZero"
  }
}

module "aws_cloudtrail" {
  count = local.cloudtrail_enabled ? 1 : 0

  source         = "trussworks/cloudtrail/aws"
  s3_bucket_name = module.logs.aws_logs_bucket

  log_retention_days = 90

  tags = local.tags
}

module "logs" {
  count = local.cloudtrail_enabled ? 1 : 0

  source  = "trussworks/logs/aws"
  version = "~> 12"

  s3_bucket_name = "${local.prefix}-aws-logs"

  default_allow = true

  force_destroy = true

  tags = local.tags
}
