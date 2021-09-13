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

resource "azuread_group_member" "member" {
  group_object_id  = azuread_group.group.id
  member_object_id = data.azuread_user.user.id
}

# Parameterisera + bygg ekvivalent i Bicep/ARM!