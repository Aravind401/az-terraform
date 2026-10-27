output "cache_id" {
  description = "ID of the Azure Cache for Redis instance."
  value       = azurerm_redis_cache.this.id
}

output "cache_hostname" {
  description = "Hostname of the Redis cache."
  value       = azurerm_redis_cache.this.hostname
}

output "cache_ssl_port" {
  description = "TLS port for client connections."
  value       = azurerm_redis_cache.this.ssl_port
}
