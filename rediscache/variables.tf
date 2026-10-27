variable "resource_group_name" {
  description = "Name of the existing resource group for the Redis cache."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the Redis cache."
  type        = string
}

variable "cache_name" {
  description = "Globally unique name for the Azure Cache for Redis instance."
  type        = string
}

variable "sku_name" {
  description = "Redis cache SKU: Basic, Standard, or Premium."
  type        = string
  default     = "Basic"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = "sku_name must be Basic, Standard, or Premium."
  }
}

variable "family" {
  description = "Redis cache SKU family: C for Basic/Standard or P for Premium."
  type        = string
  default     = "C"

  validation {
    condition     = contains(["C", "P"], var.family)
    error_message = "family must be C or P."
  }
}

variable "capacity" {
  description = "Redis cache capacity. Available sizes depend on the selected SKU family."
  type        = number
  default     = 0

  validation {
    condition     = var.capacity >= 0 && var.capacity <= 6
    error_message = "capacity must be between 0 and 6; confirm the selected SKU supports it."
  }
}

variable "allowed_ip_ranges" {
  description = "Map of named client IP ranges allowed by the cache firewall. At least one range is required."
  type = map(object({
    start_ip = string
    end_ip   = string
  }))

  validation {
    condition     = length(var.allowed_ip_ranges) > 0
    error_message = "Provide at least one trusted client IP range."
  }
}

variable "tags" {
  description = "Tags to apply to the Redis cache."
  type        = map(string)
  default     = {}
}
