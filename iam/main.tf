provider "aws" {
  profile = "<profile>"
  region  = "us-west-2"
}

terraform {
  backend "s3" {
    bucket  = "opszero-<profile>-terraform-tfstate"
    region  = "us-east-1"
    profile = "<profile>"
    encrypt = "true"

    key = "iam"
  }
}

resource "aws_iam_policy" "deployer" {
  name        = "github-deployer-policy"
  description = "Github Deployer"

  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeCluster",
                "eks:ListClusters"
            ],
            "Resource": "*"
        }
    ]
}
EOT
}


module "users" {
  source = "github.com/opszero/terraform-aws-mrmgr"

  github = {
    "deployer" = {
      org = ""
      repos = [
        "reponame"
      ]
      policy_arns = [aws_iam_policy.deployer.arn]
    }
  }

  groups = {
    "Admin" = {
      policy_arns = [
        "arn:aws:iam::aws:policy/AdministratorAccess"
      ]
      enable_mfa = true
    }
  }

  users = {
    "opszero" = {
      groups = [
        "Admin"
      ]
    }
}