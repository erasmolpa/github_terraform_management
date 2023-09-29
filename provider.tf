
# Configure the GitHub Provider
provider "github" {
  version      = "~> 2.2"
  organization = "<github-org-name>"
  # Export the GITHUB_TOKEN as an environment variable
}
