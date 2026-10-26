variable "resource_group_name" {
  description = "Name of the existing resource group for the Storage Account."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the Storage Account."
  type        = string
}

variable "storage_account_name" {
  description = "Globally unique Storage Account name, 3-24 lowercase letters or numbers."
  type        = string
}

variable "account_tier" {
  description = "Performance tier for the Storage Account: Standard or Premium."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Storage replication type, such as LRS, GRS, ZRS, or RAGRS."
  type        = string
  default     = "LRS"
}

variable "account_kind" {
  description = "Storage Account kind, such as StorageV2."
  type        = string
  default     = "StorageV2"
}

variable "min_tls_version" {
  description = "Minimum TLS version accepted by the Storage Account."
  type        = string
  default     = "TLS1_2"
}

variable "tags" {
  description = "Tags to apply to the Storage Account."
  type        = map(string)
  default     = {}
}
