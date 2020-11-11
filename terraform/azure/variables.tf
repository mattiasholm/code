variable "rgName" {
  type    = string
}

variable "rgLocation" {
  type = string
}

variable "tags" {
  type = map
}

variable "vnetAddressPrefix" {
    type = list(string)
}
