terraform {
  required_version = "~> 1.2.0"

  cloud {
    organization = "mattiasholm"

    workspaces {
      name = "azure"
    }
  }

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.28.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.20.0"
    }
  }
}
