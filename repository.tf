# The terraform resource for the repository
# Add a user to the organization
resource "github_membership" "erasmolpa" {
  username = "erasmolpa"
  role     = "admin"   # or "admin" for an org owner
}
resource "github_team" "my-team" {
  name        = "my-team"
  description = "My cool team"
}
resource "github_membership" "my_team_membership" {
  team_id  = "${github_team.my-team.id}"
  username = "erasmolpa"
  role     = "admin"
}
resource "github_repository" "github-management" {
  name        = "demo-terraform-management"
  description = "Terraform based repository"
  private            = true
  has_issues         = true
  has_wiki           = false
  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = true
  auto_init          = false
  license_template   = "mit"
  gitignore_template = "VisualStudio"
  topics             = ["config", "terraform"]
}

resource "github_team_repository" "some_team_repo" {
  team_id    = "${github_team.my-team.id}"
  repository = "${github_repository.some-repo.name}"
  permission = "pull"
}


#Set default branch 'master'
resource "github_branch_default" "master" {
  repository = github_repository.repo.name
  branch     = "master"
}

#Create branch protection rule to protect the default branch. (Use "github_branch_protection_v3" resource for Organisation rules)
resource "github_branch_protection" "default" {
  repository_id                   = github_repository.repo.id
  pattern                         = github_branch_default.master.branch
  require_conversation_resolution = true
  enforce_admins                  = true

  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}