module "github" {
  source = "github.com/opszero/terraform-github-mrmgr"

  owner = "opszero"

  repos = {
    "example" = {
      description = "example repo"
      visibility  = "public"
    }
  }

  teams = {
    "Biz" = {
      team_description     = "test team"
      privacy              = "closed"
      users                = ["abhiyerra"]
      role                 = ["member"]
      team_repos           = ["example"]
      team_repo_permission = ["push"]
    },
    "Dev" = {
      team_description     = "test team"
      privacy              = "closed"
      users                = ["abhiyerra"]
      role                 = ["member"]
      team_repos           = []
      team_repo_permission = []
    },
    "DevOps" = {
      team_description     = "test team"
      privacy              = "closed"
      users                = []
      role                 = []
      team_repos           = []
      team_repo_permission = []
    }
  }
}
