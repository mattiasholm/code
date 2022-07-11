provider "github" {
  owner = "mattiasholm"
}

resource "github_repository" "repo" {
  name        = "terraform"
  description = "Repository created with Terraform"
  auto_init   = true
}
