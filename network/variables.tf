variable "resource_group_name" {
  description = "Name of the existing resource group for the virtual network."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the virtual network."
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "Address space assigned to the virtual network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "CIDR address prefix for each purpose-specific subnet."
  type = object({
    container_apps = string
    web_apps       = string
    function_app   = string
    database       = string
    other_services = string
  })
  default = {
    container_apps = "10.0.1.0/24"
    web_apps       = "10.0.2.0/24"
    function_app   = "10.0.3.0/24"
    database       = "10.0.4.0/24"
    other_services = "10.0.5.0/24"
  }
}
