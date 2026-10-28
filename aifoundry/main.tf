resource "azurerm_cognitive_account" "this" {
  name                          = var.foundry_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  kind                          = "AIServices"
  sku_name                      = var.sku_name
  custom_subdomain_name         = var.custom_subdomain_name
  project_management_enabled    = true
  local_auth_enabled            = var.local_auth_enabled
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags

  identity {
    type = "SystemAssigned"
  }
}
