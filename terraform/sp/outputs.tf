output "clientId" {
  value = azuread_application.app.application_id
}

output "clientSecret" {
  value     = azuread_application_password.secret.value
  sensitive = true
}

output "tenantId" {
  value = data.azuread_client_config.current.tenant_id
}
