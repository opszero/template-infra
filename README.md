# Infra (Template)

[![GitHub](https://img.shields.io/github/stars/opszero/template-infra?style=social)](https://github.com/opszero/template-infra)
![GitHub Issues](https://img.shields.io/github/issues/opszero/template-infra)

opsZero uses Infrastructure as Code to build all infrastructure. The directory
structure contains everything needed to run the entire Cloud infrastructure from
DNS to IAM to the Cloud. The way different components are used is through
different terraform modules.

opsZero support:

- [Docs](https://docs.opszero.com)
- [Helpdesk](https://support.opszero.com)
- Shared Slack

## Structure

- `dns`: DNS and Cloudflare Access
  - [terraform-cloudflare-edge](https://github.com/opszero/terraform-aws-mrmgr). Configure IAM resources including Github OIDC, Gitlab OIDC, and IAM.
- `identity`:
  - Setting up
- `monitoring`: Monitoring configuration
  - [terraform-datadog-panopticon](https://github.com/opszero/terraform-datadog-panopticon): Datadog powered panopticon.
- `environments`: Cloud Kubernetes Clusters, Common Cloud Terraform, Shared Terraform
  - `<environment>`: Individual environments. e.g prod, dev, staging.
    - Bastion
      - [terraform-aws-bastion](https://github.com/opszero/terraform-aws-bastion). AWS Bastion / Instance with EC2 Instance Connect
    - Kubernetes
      - [terraform-aws-kubespot](https://github.com/opszero/terraform-aws-kubespot). AWS Configuration
      - [terraform-helm-kubespot](https://github.com/opszero/terraform-helm-kubespot). Common Helm Charts.
  - `shared/<shared>`: Shared Terraform ~modules~ used by environments. e.g S3 Bucket configuration
  - `common/<common>`: Common Terraform ~resources~ used across environments. e.g ECR


# Compliance

To enable the compliance for SOC2, CMMC, HIPAA, ITAR, PCI-DSS please follow the following:

 - AWS module
   - `common/compliance`
     - `cloudtrail_enabled = true`: Add Cloudtrail for the AWS regions.


 - `bin/aws-log-group-retention-update.py --profile <account>`: Update the AWS Retention period to 365 days.


# Tools & Setup

```
brew install kubectl kubernetes-helm awscli terraform azure-cli
```

## Makefile

- `make fmt`: Run `terraform fmt`
