# Infra

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

 - `edge`: DNS and Cloudflare Access
   - [terraform-cloudflare-edge](https://github.com/opszero/terraform-aws-mrmgr). Configure IAM resources including Github OIDC, Gitlab OIDC, and IAM.
 - `identity`: 
   - `github`: Setup Github level IAM and Access
   - `iam`: Setup Cloud level IAM and Access.
     - [terraform-aws-mrmgr](https://github.com/opszero/terraform-aws-mrmgr). Configure IAM resources including Github OIDC, Gitlab OIDC, and IAM.
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

# Tools & Setup

```
brew install kubectl kubernetes-helm awscli terraform
```


## Makefile

 - `make fmt`: Run `terraform fmt`
