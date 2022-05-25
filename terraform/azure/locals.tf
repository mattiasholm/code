locals {
  prefix         = lower("${var.tags["Company"]}-${var.tags["Application"]}")
  prefixStripped = replace(local.prefix, "-", "")
}
