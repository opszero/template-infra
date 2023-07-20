provider "aws" {
  profile = "account-name"
  region  = "us-east-1"
}

module "elb-cloudwatch" {
  source = "github.com/opszero/terraform-aws-elb-cloudwatch"

  load_balancer_arn = ""
}
