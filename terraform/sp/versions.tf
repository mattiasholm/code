terraform {
  required_version = "~> 1.2.0"

  cloud {
    organization = "mattiasholm"

    workspaces {
      name = "sp"
    }
  }

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.26.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.13.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.7.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
  }
}
