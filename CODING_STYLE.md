# Coding Style

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

## Pull Request Checklist

### Cloud

 - [ ] Are the Regions Consistent? Make sure that everything is in the same
       region. Example, us-west-2 and that regions aren't mixed unless you are
       deploying to different regions.
 - [ ] Ensure CIDR Blocks Don't Conflict

### Docs

 - [ ] Is the README.md updated?

### Style

 - [ ] Remove Trailing Whitespace

### Terraform

 - [ ] `terraform fmt`
 - [ ] Files should have underscores. Example, `cloud_file.tf` NOT `cloud-file.tf`
 - [ ] Resources should have underscores. `resource "aws_ec2_instance" "analytics_bastion"`
 - [ ] Modules should have dashes. `module "analytics-bastion"`

### Helm

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


### Github Actions

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
