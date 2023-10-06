terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
  organization = var.github_organization
  token        = var.github_token
  # Export the GITHUB_TOKEN as an environment variable
}