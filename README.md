# opsZero infra-template

infra-template is the infrastructure template used by opsZero. It sets up a common
directory structure and


## Structure

 - `cloudflare`: DNS and Cloudflare Access
 - `environments`: Cloud Kubernetes Clusters, Common Cloud Terraform, Shared Terraform
 - `iam`: Setup IAM & SSO access to clusters.
 - `secrets`: Store and manage secrets.
   - `ssm`: Store secrets in AWS Systems Manager Parameter Store


## Makefile

 - `make fmt`: Run `terraform fmt`



Git Repository

We have the structure of the infrastructure repositories consistent. This will
make life easier for everyone.

Structure:

```
infrastructure/terraform/environments/{customer}-staging # For staging kubespot
infrastructure/terraform/environments/{customer}-production # for terraform files
infrastructure/terraform/environments/common # for common terraform across all envs
infrastructure/terraform/environments/shared # for terraform modules shared between envs.

```
Code
Prefer Terraform for everything and minimize the amount of code that you have to write outside of that. If code is generic move it to modules or open source it.

Preferred glue language is Python

Git
Make branches and work on the branches.

git checkout master
git pull
git checkout -b <branch>... # Code
git add -p
git commit
git push origin <branch>
hub pull-request # Or create a Pull request on the Github repo
Pull Requests
Please make pull requests even if you are not done with your work. We want to give you feedback quickly and make sure that your code is on track. The PullRequest should reference the Issue that is to be closed. Say you are closing https://github.com/opszero/kubespot/issues/99 \

The Pull Request Message should have:

Closes #99
Docs: https://help.github.com/articles/closing-issues-using-keywords/

Machine Setup
Install VSCode
Install VSCode Share
Install Docker
Code Review
Helm
Are you missing a --- somewhere?
