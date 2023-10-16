terraform {
  required_version = "~> 1.6.0"

  cloud {
    hostname     = "app.terraform.io"
    organization = "mattiasholm"

    workspaces {
      name = "github"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.39.0"
    }
  }
}

provider "github" {
  owner = "mattiasholm"
}
