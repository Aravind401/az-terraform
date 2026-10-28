output "foundry_account_id" {
  description = "ID of the created Microsoft Foundry account."
  value       = azurerm_cognitive_account.this.id
}

output "foundry_account_name" {
  description = "Name of the created Microsoft Foundry account."
  value       = azurerm_cognitive_account.this.name
}

output "endpoint" {
  description = "Endpoint URL for the Microsoft Foundry account."
  value       = azurerm_cognitive_account.this.endpoint
}

output "principal_id" {
  description = "Principal ID of the account's system-assigned managed identity."
  value       = azurerm_cognitive_account.this.identity[0].principal_id
}
