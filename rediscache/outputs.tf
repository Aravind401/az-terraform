output "cache_id" {
  description = "ID of the Azure Managed Redis instance."
  value       = azurerm_managed_redis.this.id
}

output "cache_hostname" {
  description = "Hostname of the Azure Managed Redis instance."
  value       = azurerm_managed_redis.this.hostname
}

output "cache_port" {
  description = "TLS port for connections to the default Redis database."
  value       = azurerm_managed_redis.this.default_database[0].port
}
