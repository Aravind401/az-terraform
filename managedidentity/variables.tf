variable "resource_group_name" {
  description = "Name of the existing resource group for the managed identity."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the managed identity."
  type        = string
}

variable "managed_identity_name" {
  description = "Name of the user-assigned managed identity."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the managed identity."
  type        = map(string)
  default     = {}
}
