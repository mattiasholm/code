terraform {
  required_version = "~> 0.15.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.59.0"
    }
  }

  backend "remote" {
    organization = "mattiasholm"

    workspaces {
      name = "code"
    }
  }
}

provider "azurerm" {
  features {}
}
