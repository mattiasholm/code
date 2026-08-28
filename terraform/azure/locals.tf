locals {
  prefix          = lower("${var.tags.Company}-${var.tags.Application}")
  prefix_stripped = replace(local.prefix, "-", "")
  vnet_size       = split("/", var.vnet_cidr)[1]

  name = {
    rg   = "rg-${local.prefix}-001"
    log  = "log-${local.prefix}-001"
    kv   = "kv-${local.prefix}-001"
    vnet = "vnet-${local.prefix}-001"
    pip = {
      for label in var.pip_labels :
      label => "pip-${local.prefix}-${format("%03d", index(var.pip_labels, label) + 1)}"
    }
    st = [
      for index in range(var.st_count) :
      "st${local.prefix_stripped}${format("%03d", index + 1)}"
    ]
    snet = [
      for index in range(var.snet_count) :
      "snet-${local.prefix}-${format("%03d", index + 1)}"
    ]
  }

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
