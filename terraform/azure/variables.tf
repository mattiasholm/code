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
  type    = map(any)
  default = {}
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
variable "kvUsername" {
  type = string
}
variable "kvKeyPermissions" {
  type = list(string)
}
variable "kvSecretPermissions" {
  type = list(string)
}
variable "kvCertificatePermissions" {
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
  type = list(string)
}
variable "pipSku" {
  type    = string
  default = "Basic"
  validation {
    condition     = var.pipSku == "Basic" || var.pipSku == "Standard"
    error_message = "Invalid value for variable."
  }
}
variable "pipAllocation" {
  type    = string
  default = "Dynamic"
  validation {
    condition     = var.pipAllocation == "Dynamic" || var.pipAllocation == "Static"
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

variable "vnetAddressPrefix" {
  type    = string
  default = ""
}
