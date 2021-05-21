variable "prefix" {
  type = string
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

variable "appDockerImageTags" {
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

variable "appHttp20Enabled" {
  type    = bool
  default = true
}

variable "appMinTlsVersion" {
  type    = string
  default = "1.2"
  validation {
    condition     = var.appMinTlsVersion == "1.0" || var.appMinTlsVersion == "1.1" || var.appMinTlsVersion == "1.2"
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

variable "appClientAffinityEnabled" {
  type    = bool
  default = false
}

variable "appHttpsOnly" {
  type    = bool
  default = true
}