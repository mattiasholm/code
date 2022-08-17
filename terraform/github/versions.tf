terraform {
  required_version = "~> 1.2.0"

  cloud {
    organization = "mattiasholm"

    workspaces {
      name = "github"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.29.0"
    }
  }
}
