output "search_service_id" {
  description = "ID of the created Search Service."
  value       = azurerm_search_service.this.id
}

output "search_service_name" {
  description = "Name of the created Search Service."
  value       = azurerm_search_service.this.name
}

output "endpoint" {
  description = "Endpoint URL for the Search Service."
  value       = azurerm_search_service.this.endpoint
}
