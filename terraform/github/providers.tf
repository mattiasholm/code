terraform {
  required_version = "~> 1.10.0"

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
      version = "~> 6.3.0"
    }
  }
}

provider "github" {
  owner = "mattiasholm"
}
