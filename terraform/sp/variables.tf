variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "name" {
  type = string

  validation {
    condition     = can(regex("^sp-[a-z]+-[0-9]{2}$", var.name))
    error_message = "Invalid value for variable."
  }
}

variable "api" {
  type = string
}

variable "permissions" {
  type = map(list(string))
}

variable "role_name" {
  type = string
}

variable "secret_name" {
  type = string
}

variable "secret_rotation" {
  type    = number
  default = 365

  validation {
    condition     = var.secret_rotation < 730
    error_message = "Invalid value for variable."
  }
}

variable "audiences" {
  type = list(string)
}

variable "issuer" {
  type = string
}

variable "subjects" {
  type = map(string)
}
