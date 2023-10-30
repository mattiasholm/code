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
  type    = map(string)
  default = {}
}

variable "appi_type" {
  type    = string
  default = ""

  validation {
    condition     = contains(["", "web", "java", "store", "ios", "phone", "other"], var.appi_type)
    error_message = "Invalid value for variable."
  }
}

variable "kv_sku" {
  type    = string
  default = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.kv_sku)
    error_message = "Invalid value for variable."
  }
}

variable "kv_user_name" {
  type = string
}

variable "kv_user_key_permissions" {
  type = list(string)
}

variable "kv_user_secret_permissions" {
  type = list(string)
}

variable "kv_user_certificate_permissions" {
  type = list(string)
}

variable "kv_sp_name" {
  type = string
}

variable "kv_sp_secret_permissions" {
  type = list(string)
}

variable "pdnsz_name" {
  type = string
}

variable "pdnsz_registration" {
  type    = bool
  default = false
}

variable "pdnsz_ttl" {
  type    = number
  default = 3600
}

variable "pip_labels" {
  type = set(string)
}

variable "pip_sku" {
  type    = string
  default = "Basic"

  validation {
    condition     = contains(["Basic", "Standard"], var.pip_sku)
    error_message = "Invalid value for variable."
  }
}

variable "pip_allocation" {
  type    = string
  default = "Dynamic"

  validation {
    condition     = contains(["Dynamic", "Static"], var.pip_allocation)
    error_message = "Invalid value for variable."
  }
}

variable "st_count" {
  type    = number
  default = 1
}

variable "st_kind" {
  type    = string
  default = "StorageV2"

  validation {
    condition     = contains(["Storage", "StorageV2", "BlobStorage", "FileStorage", "BlockBlobStorage"], var.st_kind)
    error_message = "Invalid value for variable."
  }
}

variable "st_sku" {
  type    = string
  default = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.st_sku)
    error_message = "Invalid value for variable."
  }
}

variable "st_replication" {
  type    = string
  default = "LRS"

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "RAGRS", "GZRS", "RAGZRS"], var.st_replication)
    error_message = "Invalid value for variable."
  }
}

variable "st_public_access" {
  type    = bool
  default = false
}

variable "st_https_only" {
  type    = bool
  default = true
}

variable "st_tls_version" {
  type    = string
  default = "TLS1_2"

  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.st_tls_version)
    error_message = "Invalid value for variable."
  }
}

variable "vnet_address_prefix" {
  type = string
}
