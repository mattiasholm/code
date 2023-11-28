data "azuread_client_config" "user" {}

data "azurerm_subscription" "sub" {}

data "azuread_application_published_app_ids" "app_ids" {}

data "azuread_service_principal" "sp" {
  client_id = data.azuread_application_published_app_ids.app_ids.result[var.api]
}

resource "azuread_application" "app" {
  display_name = var.name
  owners = [
    data.azuread_client_config.user.object_id
  ]

  required_resource_access {
    resource_app_id = data.azuread_application_published_app_ids.app_ids.result[var.api]

    dynamic "resource_access" {
      for_each = try(var.permissions.roles, [])

      content {
        id   = data.azuread_service_principal.sp.app_role_ids[resource_access.value]
        type = "Role"
      }
    }

    dynamic "resource_access" {
      for_each = try(var.permissions.scopes, [])

      content {
        id   = data.azuread_service_principal.sp.oauth2_permission_scope_ids[resource_access.value]
        type = "Scope"
      }
    }
  }
}

resource "azuread_service_principal" "sp" {
  client_id = azuread_application.app.client_id
  owners = [
    data.azuread_client_config.user.object_id
  ]
}

resource "azurerm_role_assignment" "role" {
  principal_id         = azuread_service_principal.sp.object_id
  role_definition_name = var.role_name
  scope                = data.azurerm_subscription.sub.id
}

resource "time_rotating" "rotation" {
  rotation_days = var.secret_expiration
}

resource "azuread_application_password" "secret" {
  display_name      = var.secret_name
  application_id    = azuread_application.app.id
  end_date_relative = "${var.secret_expiration * 24}h"
  rotate_when_changed = {
    rotation = time_rotating.rotation.id
  }
}

resource "azuread_application_federated_identity_credential" "credential" {
  for_each       = var.subjects
  display_name   = each.key
  application_id = azuread_application.app.id
  audiences      = var.audiences
  issuer         = var.issuer
  subject        = each.value
}

resource "azuread_app_role_assignment" "assignment" {
  for_each            = toset(var.permissions.roles)
  resource_object_id  = data.azuread_service_principal.sp.object_id
  app_role_id         = data.azuread_service_principal.sp.app_role_ids[each.value]
  principal_object_id = azuread_service_principal.sp.object_id
}
