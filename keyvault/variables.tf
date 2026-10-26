variable "resource_group_name" {
  description = "Name of the existing resource group for the Key Vault."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID for the Key Vault."
  type        = string
}

variable "key_vault_name" {
  description = "Globally unique Key Vault name, 3-24 characters using letters, numbers, and hyphens."
  type        = string
}

variable "sku_name" {
  description = "Key Vault SKU: standard or premium."
  type        = string
  default     = "standard"
}

variable "soft_delete_retention_days" {
  description = "Number of days deleted vault objects are retained, from 7 to 90."
  type        = number
  default     = 90

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days must be between 7 and 90."
  }
}

variable "purge_protection_enabled" {
  description = "Prevent permanent deletion of soft-deleted vault objects before retention expires."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the Key Vault."
  type        = map(string)
  default     = {}
}
