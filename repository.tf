
resource "github_repository" "github-management" {
  name               = "repo-created-with-terraform"
  description        = "Terraform based repository"
  visibility         = "internal"
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