variable "resource_group_name" {
  description = "Name of the existing resource group for the PostgreSQL resources."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the PostgreSQL server."
  type        = string
}

variable "server_name" {
  description = "Globally unique name for the PostgreSQL Flexible Server."
  type        = string
}

variable "database_name" {
  description = "Name of the database to create on the server."
  type        = string
  default     = "appdb"
}

variable "administrator_login" {
  description = "Administrator login name for the PostgreSQL server."
  type        = string
  default     = "pgadmin"
}

variable "administrator_password" {
  description = "Administrator password. Terraform stores it in state; protect the state file."
  type        = string
  sensitive   = true
}

variable "postgresql_version" {
  description = "PostgreSQL major version."
  type        = string
  default     = "16"
}

variable "sku_name" {
  description = "Compute SKU for the PostgreSQL Flexible Server."
  type        = string
  default     = "B_Standard_B1ms"
}

variable "storage_mb" {
  description = "Server storage size in MiB."
  type        = number
  default     = 32768
}

variable "backup_retention_days" {
  description = "Number of days to retain backups (between 7 and 35)."
  type        = number
  default     = 7

  validation {
    condition     = var.backup_retention_days >= 7 && var.backup_retention_days <= 35
    error_message = "backup_retention_days must be between 7 and 35."
  }
}

variable "allowed_ip_ranges" {
  description = "Map of named client IP ranges allowed through the public firewall. Empty denies all client IPs."
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to the PostgreSQL server."
  type        = map(string)
  default     = {}
}
