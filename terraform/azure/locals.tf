locals {
  prefix          = lower("${var.tags.Company}-${var.tags.Application}")
  prefix_stripped = replace(local.prefix, "-", "")
  vnet_size       = split("/", var.vnet_address_prefix)[1]

  access_policies = { for key, value in {
    (data.azuread_user.user.object_id)            = var.kv_user_secret_permissions
    (data.azuread_service_principal.sp.object_id) = var.kv_sp_secret_permissions
  } : key => value if length(value) != 0 }
}
