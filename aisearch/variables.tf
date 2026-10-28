variable "resource_group_name" {
  description = "Name of the existing resource group for the Search Service."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the Search Service."
  type        = string
}

variable "search_service_name" {
  description = "Globally unique name for the Azure AI Search service."
  type        = string
}

variable "sku" {
  description = "SKU for the Search Service, such as free, basic, or standard."
  type        = string
  default     = "basic"
}

variable "local_authentication_enabled" {
  description = "Allow API key authentication in addition to Microsoft Entra authentication."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Allow access to the Search Service over its public endpoint."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the Search Service."
  type        = map(string)
  default     = {}
}
