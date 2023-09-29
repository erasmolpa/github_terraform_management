
# Add the terraform cloud backend for running locally
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "<tc-org-name>"

    workspaces {
      name = "github-management"
    }
  }
}
