provider "aws" {
  profile = "sample"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "opszero-sample-terraform-tfstate"
    region  = "us-east-1"
    profile = "sample"
    encrypt = "true"

    key = "sample-env"
  }
}

provider "helm" {
  kubernetes {
    config_path = "./kubeconfig"
    # host                   = module.opszero-eks.eks_cluster.endpoint
    # cluster_ca_certificate = base64decode(module.eks_cluster.certificate_authority.0.data)
    # token                  = module.eks_cluster.token
  }
}

locals {
  environment_name = "sample"
  legacy_vpc_id = ""
}

module "opszero-eks" {
  source = "github.com/opszero/terraform-aws-kubespot"

  zones = [
    "us-east-1a",
    "us-east-1b"
  ]

  cluster_version  = "1.23"
  environment_name = local.environment_name

  iam_users = [
    "abhiyerra",
    "bpease",
  ]
  sso_roles = {
    admin_roles = [
      "arn:aws:iam::12345:role/github-deployer",
    ]
    readonly_roles = []
    dev_roles = []
    monitoring_roles = []
  }


  cidr_block = "10.3.0.0/16"
  cidr_block_public_subnet = [
    "10.3.0.0/18",
    "10.3.64.0/18",
  ]
  cidr_block_private_subnet = [
    "10.3.128.0/18",
    "10.3.192.0/18",
  ]

  enable_nat             = false
  nodes_in_public_subnet = false

  nodes_green_instance_type    = "t3a.large"
  nodes_green_desired_capacity = 0
  nodes_green_min_size         = 0
  nodes_green_max_size         = 0
  nodes_blue_instance_type     = "t3a.large"
  nodes_blue_desired_capacity  = 0
  nodes_blue_min_size          = 0
  nodes_blue_max_size          = 0

  node_groups = {
    "medium" = {
      instance_types         = ["t3a.large"]
      nodes_in_public_subnet = true,
      node_disk_size         = 20,
      node_desired_capacity  = 2,
      nodes_max_size         = 2,
      nodes_min_size         = 2
    }
  }

  # node_role_policies = [
  #   aws_iam_policy.nodes,
  # ]

  redis_enabled        = false
  sql_cluster_enabled  = false
  sql_instance_enabled = false

  vpc_flow_logs_enabled = true

  efs_enabled = true

  legacy_subnet = false
}

module "helm-common" {
  source             = "github.com/opszero/terraform-helm-kubespot"
  cert_manager_email = "abhi@opszero.com"
}

#resource "aws_iam_policy" "nodes" {
#   name = "${var.environment_name}-common"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "s3:*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       }
#     ]
#   })
# }

# module "vpc_peering_to_legacy" {
#   source  = "grem11n/vpc-peering/aws"
#   version = "4.1.0"

#   providers = {
#     aws.this = aws
#     aws.peer = aws
#   }

#   this_vpc_id = module.opszero-eks.vpc_id
#   peer_vpc_id = local.legacy_vpc_id

#   auto_accept_peering = true
#   this_dns_resolution = true
#   peer_dns_resolution = true

#   tags = {
#     Name                = "${local.environment_name}-to-old-vpc"
#     KubespotEnvironment = local.environment_name
#   }
# }
