# Infra Template

[Infra Template](https://github.com/opszero/template-infra) is the
infrastructure as code template used by opsZero. It sets up a common directory
structure for IAM, DNS, Secrets, and Environments. All code is kept primarily
as Terraform

## Structure

 - `iam`: Setup IAM & SSO access to clusters.
 - `dns`: DNS and Cloudflare Access
 - `secrets`: Store and manage secrets.
   - `ssm`: Store secrets in AWS Systems Manager Parameter Store
 - `environments`: Cloud Kubernetes Clusters, Common Cloud Terraform, Shared Terraform

## Makefile

 - `make fmt`: Run `terraform fmt`

## Git

Make branches and work on the branches.

```
git checkout master
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
https://github.com/opszero/kubespot/issues/99

The Pull Request Message should have:

```
Closes #99
```

Docs: https://help.github.com/articles/closing-issues-using-keywords/