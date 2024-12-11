locals {
  prefix          = lower("${var.tags.Company}-${var.tags.Application}")
  prefix_stripped = replace(local.prefix, "-", "")
  vnet_size       = split("/", var.vnet_cidr)[1]

  roles = {
    user = {
      principal = data.azuread_user.user.object_id
      role      = var.user_role
    }
    sp = {
      principal = data.azuread_service_principal.sp.object_id
      role      = var.sp_role

    }
  }
}
