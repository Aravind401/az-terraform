resource "azurerm_search_service" "this" {
  name                          = var.search_service_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  local_authentication_enabled  = var.local_authentication_enabled
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
}
