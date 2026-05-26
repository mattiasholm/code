terraform {
  required_version = "~> 1.15.4"

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
      version = "~> 6.12.1"
    }
  }
}

provider "github" {
  owner = "mattiasholm"
}
