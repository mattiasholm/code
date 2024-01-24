locals {
  prefix          = lower("${var.tags.Company}-${var.tags.Application}")
  prefix_stripped = replace(local.prefix, "-", "")
  vnet_size       = split("/", var.vnet_address_prefix)[1]
}
