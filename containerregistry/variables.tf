variable "resource_group_name" {
  description = "Name of the existing resource group for the Container Registry."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the Container Registry."
  type        = string
}

variable "container_registry_name" {
  description = "Globally unique name for the Container Registry; use only letters and numbers."
  type        = string
}

variable "sku" {
  description = "SKU for the Container Registry: Basic, Standard, or Premium."
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Enable the registry's legacy admin account. Prefer Microsoft Entra authentication where possible."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the Container Registry."
  type        = map(string)
  default     = {}
}
