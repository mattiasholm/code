variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "name" {
  type = string
  validation {
    condition     = can(regex("^sp-[a-z]+-[0-9]{3}$", var.name))
    error_message = "Invalid value for variable."
  }
}

variable "api" {
  type = string
}

variable "permission" {
  type = string
}

variable "role_name" {
  type = string
}

variable "secret_name" {
  type = string
}

variable "secret_expiration" {
  type    = number
  default = 365
  validation {
    condition     = var.secret_expiration < 730
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
