resource "github_repository" "repo" {
  name        = "terraform"
  description = "Repository created with Terraform"
  auto_init   = true
}

output "cloneUrl" {
  value = github_repository.repo.http_clone_url
}
