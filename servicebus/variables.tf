variable "resource_group_name" {
  description = "Name of the existing resource group for the Service Bus resources."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the Service Bus namespace."
  type        = string
}

variable "namespace_name" {
  description = "Globally unique name for the Service Bus namespace."
  type        = string
}

variable "queue_name" {
  description = "Name of the queue to create in the namespace."
  type        = string
  default     = "app-queue"
}

variable "sku" {
  description = "Service Bus namespace SKU. Standard supports queues and topics."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.sku)
    error_message = "sku must be Standard or Premium."
  }
}

variable "tags" {
  description = "Tags to apply to the Service Bus namespace."
  type        = map(string)
  default     = {}
}
