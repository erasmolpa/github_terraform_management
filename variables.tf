
variable "github_token" {
  type      = string
  sensitive = true
  default   = "gho_XXXXXXX"
}

variable "github_owner" {
  type    = string
  default = "erasmoXXXXXX"
}

variable "repository_template" {
  description = "repository template"
  default     = "repo-created-with-terraform"
}
variable "repo_data" {
  description = "Datos de los repositorios a crear"
  type = list(object({
    name           = string
    description    = string
    private        = bool
    business_unit  = string
    team           = string
    app            = string
    component      = string
    region         = string
    environment    = string
    backup_enabled = bool
    owner          = string
  }))
}
