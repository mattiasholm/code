variable "tenantId" {
  type = string
}
variable "subscriptionId" {
  type = string
}

variable "location" {
  type = string
}
variable "tags" {
  type    = map(any)
  default = {}
}

variable "appiType" {
  type    = string
  default = "web"
  validation {
    condition     = contains(["web", "ios", "other", "store", "java", "phone"], var.appiType)
    error_message = "Invalid value for variable."
  }
}

variable "kvSku" {
  type    = string
  default = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.kvSku)
    error_message = "Invalid value for variable."
  }
}
variable "kvUsername" {
  type = string
}
variable "kvUserKeyPermissions" {
  type = list(string)
}
variable "kvUserSecretPermissions" {
  type = list(string)
}
variable "kvUserCertPermissions" {
  type = list(string)
}
variable "kvSpName" {
  type = string
}
variable "kvSpSecretPermissions" {
  type = list(string)
}

variable "pdnszName" {
  type = string
}
variable "pdnszRegistration" {
  type    = bool
  default = false
}
variable "pdnszTtl" {
  type    = number
  default = 3600
}

variable "pipLabels" {
  type = map(string)
}
variable "pipSku" {
  type    = string
  default = "Basic"
  validation {
    condition     = contains(["Basic", "Standard"], var.pipSku)
    error_message = "Invalid value for variable."
  }
}
variable "pipAllocation" {
  type    = string
  default = "Dynamic"
  validation {
    condition     = contains(["Dynamic", "Static"], var.pipAllocation)
    error_message = "Invalid value for variable."
  }
}

variable "stCount" {
  type    = number
  default = 1
}
variable "stKind" {
  type    = string
  default = "StorageV2"
  validation {
    condition     = contains(["Storage", "StorageV2", "BlobStorage", "FileStorage", "BlockBlobStorage"], var.stKind)
    error_message = "Invalid value for variable."
  }
}
variable "stSku" {
  type    = string
  default = "Standard"
  validation {
    condition     = contains(["Standard", "Premium"], var.stSku)
    error_message = "Invalid value for variable."
  }
}
variable "stReplication" {
  type    = string
  default = "LRS"
  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "RAGRS", "GZRS", "RAGZRS"], var.stReplication)
    error_message = "Invalid value for variable."
  }
}
variable "stPublicAccess" {
  type    = bool
  default = false
}
variable "stHttpsOnly" {
  type    = bool
  default = true
}
variable "stTlsVersion" {
  type    = string
  default = "TLS1_2"
  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.stTlsVersion)
    error_message = "Invalid value for variable."
  }
}

variable "vnetAddressPrefix" {
  type    = string
  default = ""
}
