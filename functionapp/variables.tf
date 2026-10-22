variable "resource_group_name" {
  description = "Name of the existing resource group for the Function App resources."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the Function App resources."
  type        = string
}

variable "function_app_name" {
  description = "Globally unique name of the Linux Function App."
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the Linux App Service Plan."
  type        = string
}

variable "storage_account_name" {
  description = "Globally unique, lowercase name of the Function App storage account."
  type        = string
}

variable "node_version" {
  description = "Node.js runtime version for the Function App, such as 20."
  type        = string
  default     = "20"
}

variable "sku_name" {
  description = "SKU for the Linux Function App Service Plan."
  type        = string
  default     = "Y1"
}

variable "app_settings" {
  description = "Additional application settings. Values may contain secrets and are stored in Terraform state."
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to the storage account, App Service Plan, and Function App."
  type        = map(string)
  default     = {}
}
