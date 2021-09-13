locals {
  userId = data.azuread_user.user.id
}

data "azuread_user" "user" {
  user_principal_name = "mattias.holm@azronnieb3it.onmicrosoft.com"
}

resource "azuread_group" "group" {
  display_name = "AzureRBAC-KeyVault"
  owners = [
    local.userId
  ]
  security_enabled = true
}

# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group

# Member current user?! Blir ju dock dumt i pipeline?

# KV AP

# Parameterisera!
