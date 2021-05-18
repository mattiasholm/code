resource "azurerm_app_service" "app" {
  count                   = 2
  name                    = "app-${var.prefix}-00${count.index + 1}"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = var.location
  tags                    = var.tags
  identity {
      type = var.appIdentity
  }
  app_service_plan_id     = azurerm_app_service_plan.plan.id
  site_config {
      linux_fx_version = var.appLinuxFxVersion
      always_on = var.appAlwaysOn
      http2_enabled = var.appHttp20Enabled
      min_tls_version = var.appMinTlsVersion
      ftps_state = var.appFtpsState
}
  client_affinity_enabled = var.appClientAffinityEnabled
  https_only              = var.appHttpsOnly
}