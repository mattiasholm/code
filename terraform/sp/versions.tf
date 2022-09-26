terraform {
  required_version = "~> 1.3.0"

  cloud {
    organization = "mattiasholm"

    workspaces {
      name = "sp"
    }
  }

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.28.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.24.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.8.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
  }
}
