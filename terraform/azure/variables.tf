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




# variable "vnetAddressPrefix" {
#   type = list(string)
# }
