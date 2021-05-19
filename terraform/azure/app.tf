# https://www.terraform.io/docs/language/meta-arguments/count.html
# https://www.terraform.io/docs/language/meta-arguments/for_each.html
# https://stackoverflow.com/questions/61343796/terraform-get-list-index-on-for-each

resource "azurerm_app_service" "app" {
    count               = length(var.apps)
  # for_each = toset(var.apps.dockerImageTag)
    name                = "app-${var.prefix}-00${count.index + 1}"
  # name                = "app-${var.prefix}-${each.value}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  tags                = var.tags
  identity {
    type = var.appIdentity
  }
  app_service_plan_id = azurerm_app_service_plan.plan.id
  site_config {
    linux_fx_version = "DOCKER|nginxdemos/hello:${var.apps[count.index].dockerImageTag}"
    # linux_fx_version = "DOCKER|nginxdemos/hello:${each.value}"
    always_on        = var.appAlwaysOn
    http2_enabled    = var.appHttp20Enabled
    min_tls_version  = var.appMinTlsVersion
    ftps_state       = var.appFtpsState
  }
  client_affinity_enabled = var.appClientAffinityEnabled
  https_only              = var.appHttpsOnly
}