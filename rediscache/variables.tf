variable "resource_group_name" {
  description = "Name of the existing resource group for the Azure Managed Redis instance."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the Azure Managed Redis instance."
  type        = string
}

variable "cache_name" {
  description = "Name for the Azure Managed Redis instance. It must be unique in the region."
  type        = string
}

variable "sku_name" {
  description = "Azure Managed Redis SKU, such as Balanced_B0 or Balanced_B3."
  type        = string
  default     = "Balanced_B0"

  validation {
    condition = contains([
      "Balanced_B0", "Balanced_B1", "Balanced_B3", "Balanced_B5", "Balanced_B10",
      "Balanced_B20", "Balanced_B50", "Balanced_B100", "Balanced_B150",
      "Balanced_B250", "Balanced_B350", "Balanced_B500", "Balanced_B700",
      "Balanced_B1000", "ComputeOptimized_X3", "ComputeOptimized_X5",
      "ComputeOptimized_X10", "ComputeOptimized_X20", "ComputeOptimized_X50",
      "ComputeOptimized_X100", "ComputeOptimized_X150", "ComputeOptimized_X250",
      "ComputeOptimized_X350", "ComputeOptimized_X500", "ComputeOptimized_X700",
      "MemoryOptimized_M10", "MemoryOptimized_M20", "MemoryOptimized_M50",
      "MemoryOptimized_M100", "MemoryOptimized_M150", "MemoryOptimized_M250",
      "MemoryOptimized_M350", "MemoryOptimized_M500", "MemoryOptimized_M700",
      "MemoryOptimized_M1000", "MemoryOptimized_M1500", "MemoryOptimized_M2000",
      "FlashOptimized_A250", "FlashOptimized_A500", "FlashOptimized_A700",
      "FlashOptimized_A1000", "FlashOptimized_A1500", "FlashOptimized_A2000",
      "FlashOptimized_A4500"
    ], var.sku_name)
    error_message = "sku_name must be a supported Azure Managed Redis SKU."
  }
}

variable "tags" {
  description = "Tags to apply to the Azure Managed Redis instance."
  type        = map(string)
  default     = {}
}
