output "container_registry_id" {
  description = "ID of the created Container Registry."
  value       = azurerm_container_registry.this.id
}

output "container_registry_name" {
  description = "Name of the created Container Registry."
  value       = azurerm_container_registry.this.name
}

output "login_server" {
  description = "Login server URL for the Container Registry."
  value       = azurerm_container_registry.this.login_server
}
