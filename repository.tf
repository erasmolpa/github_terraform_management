
resource "github_repository" "github-management" {
  name        = "repo-created-with-terraform"
  description = "Terraform based repository"
  visibility  = "internal"
  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
  archive_on_destroy = true
  has_issues         = true
  has_wiki           = false
  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true
  auto_init          = false
  license_template   = "mit"
  gitignore_template = "VisualStudio"
  is_template        = true
  topics             = ["config", "terraform"]
}
resource "github_branch_protection" "github-management-branch-protection" {
  repository_id    = github_repository.github-management.node_id
  pattern          = "main"
  enforce_admins   = true
  allows_deletions = false

}
resource "github_repository_tag_protection" "github-management-tag-protection" {
  repository = github_repository.github-management.name
  pattern    = "v*"
}

# Add a repository to the team
resource "github_team" "some_team" {
  name        = "SomeTeam"
  description = "Some cool team"
}

resource "github_team_repository" "some_team_repo" {
  team_id    = github_team.some_team.id
  repository = github_repository.github-management.name
  permission = "pull"
}