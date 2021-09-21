resource "azurerm_app_service" "app" {
  for_each            = { for i, appDockerImageTag in var.appDockerImageTags : appDockerImageTag => i }
  name                = "app-${var.prefix}-${format("%03d", each.value + 1)}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  identity {
    type = var.appIdentity
  }
  app_service_plan_id = azurerm_app_service_plan.plan.id
  site_config {
    linux_fx_version = "DOCKER|nginxdemos/hello:${each.key}"
    always_on        = var.appAlwaysOn
    http2_enabled    = var.appHttp20Enabled
    min_tls_version  = var.appMinTlsVersion
    ftps_state       = var.appFtpsState
  }
  app_settings = {
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.appi.connection_string
    "KEYVAULT_URL"                          = azurerm_key_vault.kv.vault_uri
  }
  client_affinity_enabled = var.appClientAffinityEnabled
  https_only              = var.appHttpsOnly
}
