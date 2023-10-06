
variable "github_token" {
  type      = string
  sensitive = true
  default   = "XXXX"
}

variable "github_organization" {
  type    = string
  default = "org"
}