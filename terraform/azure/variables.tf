variable "prefix" {
  type = string
  validation {
    condition     = length(var.prefix) <= 17
    error_message = "Invalid value for variable."
  }
}
variable "location" {
  type = string
}
variable "tags" {
  type = map(any)
}

variable "planKind" {
  type    = string
  default = "linux"
  validation {
    condition     = var.planKind == "app" || var.planKind == "linux"
    error_message = "Invalid value for variable."
  }
}
variable "planTier" {
  type    = string
  default = "Basic"
}
variable "planSize" {
  type    = string
  default = "B1"
}
variable "planCapacity" {
  type    = number
  default = 1
  validation {
    condition     = var.planCapacity >= 1 && var.planCapacity <= 10
    error_message = "Invalid value for variable."
  }
}

variable "appDockerImages" {
  type = list(string)
}
variable "appIdentity" {
  type    = string
  default = "None"
  validation {
    condition     = var.appIdentity == "None" || var.appIdentity == "SystemAssigned"
    error_message = "Invalid value for variable."
  }
}
variable "appAlwaysOn" {
  type    = bool
  default = true
}
variable "appHttp2" {
  type    = bool
  default = true
}
variable "appTlsVersion" {
  type    = string
  default = "1.2"
  validation {
    condition     = var.appTlsVersion == "1.0" || var.appTlsVersion == "1.1" || var.appTlsVersion == "1.2"
    error_message = "Invalid value for variable."
  }
}
variable "appFtpsState" {
  type    = string
  default = "FtpsOnly"
  validation {
    condition     = var.appFtpsState == "AllAllowed" || var.appFtpsState == "FtpsOnly" || var.appFtpsState == "Disabled"
    error_message = "Invalid value for variable."
  }
}
variable "appClientAffinity" {
  type    = bool
  default = false
}
variable "appHttpsOnly" {
  type    = bool
  default = true
}

variable "appiType" {
  type    = string
  default = "web"
  validation {
    condition     = var.appiType == "web" || var.appiType == "ios" || var.appiType == "other" || var.appiType == "store" || var.appiType == "java" || var.appiType == "phone"
    error_message = "Invalid value for variable."
  }
}

variable "kvSku" {
  type    = string
  default = "standard"
  validation {
    condition     = var.kvSku == "standard" || var.kvSku == "premium"
    error_message = "Invalid value for variable."
  }
}
variable "kvAppSecretPermissions" {
  type = list(string)
}

variable "kvGroupName" {
  type = string
}

variable "kvGroupOwner" {
  type = string
}

variable "kvGroupMembers" {
  type = list(string)
}

variable "kvGroupKeyPermissions" {
  type = list(string)
}

variable "kvGroupSecretPermissions" {
  type = list(string)
}

variable "kvGroupCertPermissions" {
  type = list(string)
}

variable "kvSpName" {
  type = string
}

variable "kvSpSecretPermissions" {
  type = list(string)
}

variable "kvSecretName" {
  type = string
}

variable "stCount" {
  type    = number
  default = 1
}
variable "stKind" {
  type    = string
  default = "StorageV2"
  validation {
    condition     = var.stKind == "Storage" || var.stKind == "StorageV2" || var.stKind == "BlobStorage" || var.stKind == "FileStorage" || var.stKind == "BlockBlobStorage"
    error_message = "Invalid value for variable."
  }
}
variable "stSku" {
  type    = string
  default = "Standard"
  validation {
    condition     = var.stSku == "Standard" || var.stSku == "Premium"
    error_message = "Invalid value for variable."
  }
}
variable "stReplication" {
  type    = string
  default = "LRS"
  validation {
    condition     = var.stReplication == "LRS" || var.stReplication == "ZRS" || var.stReplication == "GRS" || var.stReplication == "RAGRS" || var.stReplication == "GZRS" || var.stReplication == "RAGZRS"
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
    condition     = var.stTlsVersion == "TLS1_0" || var.stTlsVersion == "TLS1_1" || var.stTlsVersion == "TLS1_2"
    error_message = "Invalid value for variable."
  }
}

variable "vnetToggle" {
  type    = bool
  default = false
}
variable "vnetAddressPrefix" {
  type    = string
  default = ""
}
