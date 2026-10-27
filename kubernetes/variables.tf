variable "resource_group_name" {
  description = "Name of the existing resource group for the AKS cluster."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the AKS cluster."
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster."
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool."
  type        = number
  default     = 1

  validation {
    condition     = var.node_count >= 1
    error_message = "node_count must be at least 1."
  }
}

variable "node_vm_size" {
  description = "Virtual machine size for each default node."
  type        = string
  default     = "Standard_D2s_v5"
}

variable "sku_tier" {
  description = "AKS management tier: Free or Standard."
  type        = string
  default     = "Free"

  validation {
    condition     = contains(["Free", "Standard"], var.sku_tier)
    error_message = "sku_tier must be Free or Standard."
  }
}

variable "api_server_authorized_ip_ranges" {
  description = "CIDR ranges allowed to reach the public Kubernetes API server. Provide at least one trusted range."
  type        = list(string)

  validation {
    condition     = length(var.api_server_authorized_ip_ranges) > 0 && alltrue([for cidr in var.api_server_authorized_ip_ranges : can(cidrhost(cidr, 0))])
    error_message = "Provide at least one valid CIDR range to restrict access to the API server."
  }
}

variable "tags" {
  description = "Tags to apply to the AKS cluster."
  type        = map(string)
  default     = {}
}
