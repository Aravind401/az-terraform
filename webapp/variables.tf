variable "resource_group_name" {
  description = "Name of the existing resource group for the App Service resources."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the App Service resources."
  type        = string
}

variable "web_app_name" {
  description = "Globally unique name of the Linux Web App."
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the Linux App Service Plan."
  type        = string
}

variable "node_version" {
  description = "Node.js runtime version for the Linux Web App, such as 20-lts."
  type        = string
  default     = "20-lts"
}

variable "sku_name" {
  description = "SKU for the App Service Plan."
  type        = string
  default     = "B1"
}

variable "always_on" {
  description = "Keep the Web App loaded. Set to false for SKUs that do not support always-on."
  type        = bool
  default     = true
}

variable "app_settings" {
  description = "Application settings for the Web App. Values may contain secrets and are stored in Terraform state."
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to the App Service Plan and Web App."
  type        = map(string)
  default     = {}
}
