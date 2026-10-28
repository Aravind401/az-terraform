variable "resource_group_name" {
  description = "Name of the existing resource group for the Foundry account."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the Foundry account."
  type        = string
}

variable "foundry_name" {
  description = "Globally unique name for the Microsoft Foundry account."
  type        = string
}

variable "custom_subdomain_name" {
  description = "Globally unique custom subdomain for the Foundry account."
  type        = string
}

variable "sku_name" {
  description = "SKU for the Foundry account."
  type        = string
  default     = "S0"
}

variable "local_auth_enabled" {
  description = "Allow local API key authentication for the Foundry account."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Allow access to the Foundry account over its public endpoint."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the Foundry account."
  type        = map(string)
  default     = {}
}
