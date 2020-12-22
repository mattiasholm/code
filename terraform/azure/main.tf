terraform {
  required_version = "~> 0.14.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.35.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  prefix = var.rgName
}

# Fortsätt med modules med params, inget hårdkodat i respektive template!
# https://www.terraform.io/docs/modules/index.html
# https://www.terraform.io/docs/configuration/blocks/modules/syntax.html

# var VS locals! Inte tänkt på att man såklart kan använda flera .tfvars-filer istället - måste väl vara tydligare?! Fast å andra sidan vill jag väl precis som i ARM bara bryta ut saker saker som skiljer mellan Test/Prod??
# common.tfvars (auto???) / prod.tfvars (manuell) / test.tfvars (manuell)

# Testa provider "Azure AD" !!!
# resource "random_password"

# Remote state - Storage Account, hantera utanför Terraform (duh), t.ex. az-cli!

# OPA (Open Policy Agent)

# DAG: Directed Acyclic Graph (git + terraform) https://en.wikipedia.org/wiki/Directed_acyclic_graph

# HashiCorp Packer vs !!! Ansible
