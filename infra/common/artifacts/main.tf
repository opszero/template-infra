provider "aws" {
  profile = "<profile>"
  region  = "us-west-2"
}

# terraform {
#   backend "s3" {
#     bucket  = "opszero-<profile>-terraform-tfstate"
#     region  = "us-east-1"
#     profile = "<profile>"
#     encrypt = "true"

#     key = "artifacts"
#   }
# }

locals {
  repo_names = [
    "reponame",
  ]
}

module "ecr" {
  for_each = toset(local.repo_names)
  source   = "github.com/opszero/terraform-aws-ecr"
  name     = each.key
}
