output "function_app_id" {
  description = "ID of the created Linux Function App."
  value       = azurerm_linux_function_app.this.id
}

output "function_app_name" {
  description = "Name of the created Linux Function App."
  value       = azurerm_linux_function_app.this.name
}

output "function_app_default_hostname" {
  description = "Default hostname of the created Linux Function App."
  value       = azurerm_linux_function_app.this.default_hostname
}

output "app_service_plan_id" {
  description = "ID of the created Linux App Service Plan."
  value       = azurerm_service_plan.this.id
}

output "storage_account_id" {
  description = "ID of the Function App storage account."
  value       = azurerm_storage_account.this.id
}
