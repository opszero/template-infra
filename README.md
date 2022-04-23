# Infra Template

Infrastructure as code template used by opsZero. It sets up a common directory
structure for IAM, DNS, Secrets, and Environments. All code is kept primarily
as Terraform

## Support

Contact opsZero support:

 - [Helpdesk](https://support.opszero.com)
 - Shared Slack

## Structure

 - `iam`: Setup IAM & SSO access to clusters.
   - [terraform-aws-mrmgr](https://github.com/opszero/terraform-aws-mrmgr). Configure IAM resources including Github OIDC, Gitlab OIDC, and IAM.
 - `dns`: DNS and Cloudflare Access
 - `monitoring`: Monitoring and Paging Configuration
   - [terraform-datadog-panopticon](https://github.com/opszero/terraform-datadog-panopticon): Datadog powered panopticon.
 - `secrets`: Store and manage secrets.
   - `ssm`: Store secrets in AWS Systems Manager Parameter Store
 - `environments`: Cloud Kubernetes Clusters, Common Cloud Terraform, Shared Terraform
   - `<environment>`: The individual environments.
     - [terraform-aws-kubespot](https://github.com/opszero/terraform-aws-kubespot). AWS Configuration
     - [terraform-google-kubespot](https://github.com/opszero/terraform-google-kubespot). GCP configuration.
     - [terraform-azurerm-kubespot](https://github.com/opszero/terraform-azurerm-kubespot). Azure configuration.
     - [terraform-helm-kubespot](https://github.com/opszero/terraform-helm-kubespot). Common Helm Charts.
   - `shared/<shared>`: Shared Terraform ~modules~ used by the environments
   - `common/<common>`: Common Terraform ~resources~ used across environments.

## Makefile

 - `make fmt`: Run `terraform fmt`

## Git

Make branches and work on the branches.

```
git checkout main
git pull
git checkout -b <branch>... # Code
git add -p
git commit
git push origin <branch>
gh pr create # Or create a Pull request on the Github repo
```

### Pull Requests

Pull requests are created frequently and often to ensure timely feedback.
Pull requests should reference the Issue that is to be closed. Say you are closing
https://github.com/opszero/template-infra/issues/99

The Pull Request Message should have:

```
Closes #99
```

Docs: https://help.github.com/articles/closing-issues-using-keywords/

# Checklists

 - [ ] Ensure CIDR Blocks Don't Conflict
