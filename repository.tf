locals {
  yaml_rg= yamldecode(file("${path.module}/repositories.yaml"))
}
resource "github_repository" "github-management" {
  count = length(local.yaml_rg.repo_data)

  name               = local.yaml_rg.repo_data[count.index].name
  description        = local.yaml_rg.repo_data[count.index].description
  visibility         = local.visibility
  archive_on_destroy = local.archive_on_destroy
  has_issues         = local.has_issues
  has_wiki           = local.has_wiki
  allow_merge_commit = local.allow_merge_commit
  allow_squash_merge = local.allow_squash_merge
  allow_rebase_merge = local.allow_rebase_merge
  auto_init          = local.auto_init
  license_template   = local.license_template
  gitignore_template = local.gitignore_template
  is_template        = local.is_template

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }


  template {
    repository = var.repository_template
    owner      = var.repo_data[count.index].owner ? var.repo_data[count.index].owner : var.github_owner
  }
  topics = [
    var.repo_data[count.index].business_unit,
    var.repo_data[count.index].app,
    var.repo_data[count.index].component,
    var.repo_data[count.index].region,
    var.repo_data[count.index].environment
  ]
}

resource "github_branch_protection" "github-management-branch-protection" {
  count = length(var.repo_data)

  repository_id          = github_repository.github-management[count.index].node_id
  pattern                = "main"
  enforce_admins         = true
  allows_deletions       = false
  require_signed_commits = true
}

resource "github_repository_tag_protection" "github-management-tag-protection" {
  count = length(var.repo_data)

  repository = github_repository.github-management[count.index].name
  pattern    = "v*"
}

# Add repositories to the team
resource "github_team" "some_team" {
  name        = "SomeTeam"
  description = "Some cool team"
}

resource "github_team_repository" "some_team_repo" {
  count      = length(var.repo_data)
  team_id    = github_team.some_team.id
  repository = github_repository.github-management[count.index].name
  permission = "pull"
}
