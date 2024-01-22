terraform {
  required_version = "~> 1.7.0"

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
      version = "~> 5.45.0"
    }
  }
}

provider "github" {
  owner = "mattiasholm"
}
