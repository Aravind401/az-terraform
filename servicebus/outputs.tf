output "namespace_id" {
  description = "ID of the Service Bus namespace."
  value       = azurerm_servicebus_namespace.this.id
}

output "namespace_name" {
  description = "Name of the Service Bus namespace."
  value       = azurerm_servicebus_namespace.this.name
}

output "queue_id" {
  description = "ID of the Service Bus queue."
  value       = azurerm_servicebus_queue.this.id
}

output "queue_name" {
  description = "Name of the created queue."
  value       = azurerm_servicebus_queue.this.name
}
