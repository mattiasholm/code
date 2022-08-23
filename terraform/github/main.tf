provider "github" {
  owner = "mattiasholm"
}

resource "github_repository" "repo" {
  name        = "terraform"
  description = "Repository created with Terraform"
  visibility  = "public"
  auto_init   = true
}

resource "github_repository_file" "file" {
  repository = github_repository.repo.name
  file       = ".gitignore"
  content    = ".DS_Store\n"
}

resource "github_actions_secret" "secret" {
  repository      = github_repository.repo.name
  secret_name     = "SECRET"
  plaintext_value = "secret"
}
