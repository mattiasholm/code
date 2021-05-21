# https://stackoverflow.com/questions/61343796/terraform-get-list-index-on-for-each

resource "azurerm_app_service" "app" {
  for_each            = var.appDockerImageTags
  name                = "app-${var.prefix}-00${each.value}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  identity {
    type = var.appIdentity
  }
  app_service_plan_id = azurerm_app_service_plan.plan.id
  site_config {
    linux_fx_version = "DOCKER|nginxdemos/hello:${each.value}"
    always_on        = var.appAlwaysOn
    http2_enabled    = var.appHttp20Enabled
    min_tls_version  = var.appMinTlsVersion
    ftps_state       = var.appFtpsState
  }
  client_affinity_enabled = var.appClientAffinityEnabled
  https_only              = var.appHttpsOnly
}