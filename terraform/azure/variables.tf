variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)

  validation {
    condition     = length(lower("${var.tags.Company}-${var.tags.Application}")) <= 18
    error_message = "Prefix '${lower("${var.tags.Company}-${var.tags.Application}")}' is longer than 18 characters."
  }
}

variable "log_retention" {
  type    = number
  default = null
}

variable "pdnsz_name" {
  type = string
}

variable "pip_labels" {
  type    = set(string)
  default = []
}

variable "st_count" {
  type    = number
  default = 0
}

variable "st_sku" {
  type    = string
  default = "Standard_GRS"
}

variable "vnet_cidr" {
  type = string
}

variable "snet_count" {
  type = number
}

variable "snet_size" {
  type = number
}

variable "user_name" {
  type = string
}

variable "user_role" {
  type = string
}

variable "sp_name" {
  type = string
}

variable "sp_role" {
  type = string
}
