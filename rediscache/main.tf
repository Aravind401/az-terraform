resource "azurerm_managed_redis" "this" {
  name                  = var.cache_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  sku_name              = var.sku_name
  public_network_access = "Enabled"
  tags                  = var.tags

  default_database {
    access_keys_authentication_enabled = false
    client_protocol                    = "Encrypted"
    clustering_policy                  = "OSSCluster"
  }
}
