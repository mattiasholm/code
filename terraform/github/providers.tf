terraform {
  required_version = "~> 1.5.0"

  cloud {
    organization = "mattiasholm"

    workspaces {
      name = "github"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.32.0"
    }
  }
}

provider "github" {
  owner = "mattiasholm"
}
