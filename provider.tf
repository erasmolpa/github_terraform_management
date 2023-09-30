
# Configure the GitHub Provider
provider "github" {
  version      = "~> 2.2"
  organization = "${var.github_organization}"
  token        = "${var.github_token}"
  # Export the GITHUB_TOKEN as an environment variable
}