terraform {
  required_version = "~> 0.13.5"

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
  prefix = azurerm_resource_group.rg.name
}

# Fortsätt med modules med params, inget hårdkodat i respektive template!
# https://www.terraform.io/docs/configuration/blocks/modules/syntax.html
# Lokalt vs referens direkt från GitHub??? 
# REF: https://github.com/xenitab/terraform-modules

# common.tfvars (auto???) / prod.tfvars (manuell) / test.tfvars (manuell)
# var VS locals! Inte tänkt på att man såklart kan använda flera .tfvars-filer istället - måste väl vara tydligare?! Fast å andra sidan vill jag väl precis som i ARM hålla isär saker som skiljer mellan Test/Prod??

# Testa provider "Azure AD" !!!
# resource "random_password"

# Remote state - Storage Account, hantera utanför Terraform (duh), t.ex. az-cli!

# OPA (Open Policy Agent)

# DAG: Directed Acyclic Graph (git + terraform) https://en.wikipedia.org/wiki/Directed_acyclic_graph

# HashiCorp Packer vs !!! Ansible
