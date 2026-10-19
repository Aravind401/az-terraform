output "web_app_id" {
  description = "ID of the created Linux Web App."
  value       = azurerm_linux_web_app.this.id
}

output "web_app_name" {
  description = "Name of the created Linux Web App."
  value       = azurerm_linux_web_app.this.name
}

output "web_app_default_hostname" {
  description = "Default hostname of the created Linux Web App."
  value       = azurerm_linux_web_app.this.default_hostname
}

output "app_service_plan_id" {
  description = "ID of the created Linux App Service Plan."
  value       = azurerm_service_plan.this.id
}
