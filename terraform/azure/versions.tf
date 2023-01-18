terraform {
  required_version = "~> 1.3.0"

  cloud {
    organization = "mattiasholm"

    workspaces {
      name = "azure"
    }
  }

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.32.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.39.0"
    }
  }
}
