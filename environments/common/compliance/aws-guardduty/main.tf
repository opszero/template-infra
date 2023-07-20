provider "aws" {
  profile = "account-name"
  region  = "us-east-1"
}

resource "aws_guardduty_detector" "guardduty" {
  enable = true

  datasources {
    s3_logs {
      enable = true
    }
    kubernetes {
      audit_logs {
        enable = false
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = true
        }
      }
    }
  }
}
