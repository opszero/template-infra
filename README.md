# Infra

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

## Git & Github

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

Pull requests are created frequently and often to ensure timely feedback.
Pull requests should reference the Issue that is to be closed. Say you are closing
https://github.com/opszero/template-infra/issues/99

The Pull Request Message should have:

```
Closes #99
```

Docs: https://help.github.com/articles/closing-issues-using-keywords/

### Pull Request Checklist

#### Cloud

 - [ ] Are the Regions Consistent? Make sure that everything is in the same
       region. Example, us-west-2 and that regions aren't mixed unless you are
       deploying to different regions.
 - [ ] Ensure CIDR Blocks Don't Conflict

#### Docs

 - [ ] Is the README.md updated?

#### Style

 - [ ] Remove Trailing Whitespace

#### Terraform

 - [ ] `terraform fmt`
 - [ ] Files should have underscores. Example, `cloud_file.tf` NOT `cloud-file.tf`
 - [ ] Resources should have underscores. `resource "aws_ec2_instance" "analytics_bastion"`
 - [ ] Modules should have dashes. `module "analytics-bastion"`

#### Helm

 - [ ] Prefer `helm upgrade --install` to `helm install`
 - [ ] Put charts in the `charts` directory.
 - [ ] Spelling of the chart name
 - [ ] Ensure that _helpers.tmpl is being used for metadata information.
 ```
 metadata:
  name: {{ include "fullname" . }}-jobs
  labels:
    {{- include "labels" . | nindent 4 }}
 ```
 - [ ] Run `helm template --debug charts/dir-name` to find issues.
 - [ ] Are values.yml in the correct place?


#### Github Actions

 - [ ] AWS
   - [ ] Is the AWS Account ID Correct?
   - [ ] Is the Docker Registry Created?
   - [ ] Is the name of the image correct?
 - [ ] Prefer to move environment variables to globals:
 ```
 jobs:
  deploy:
    name: Test, Build, Deploy
    runs-on: ubuntu-latest
    env:
      ECR_REGISTRY: 123456.dkr.ecr.us-west-2.amazonaws.com
      ECR_REPOSITORY: datascience
 ```
