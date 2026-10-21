output "container_app_id" {
  description = "ID of the created Container App."
  value       = azurerm_container_app.this.id
}

output "container_app_name" {
  description = "Name of the created Container App."
  value       = azurerm_container_app.this.name
}

output "container_app_environment_id" {
  description = "ID of the created Container Apps managed environment."
  value       = azurerm_container_app_environment.this.id
}

output "container_app_latest_revision_name" {
  description = "Name of the latest Container App revision."
  value       = azurerm_container_app.this.latest_revision_name
}

output "container_app_fqdn" {
  description = "Fully qualified domain name of the Container App ingress, when ingress is enabled."
  value       = try(azurerm_container_app.this.ingress[0].fqdn, null)
}
