resource "azurerm_redis_cache" "this" {
  name                          = var.cache_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  capacity                      = var.capacity
  family                        = var.family
  sku_name                      = var.sku_name
  minimum_tls_version           = "1.2"
  non_ssl_port_enabled          = false
  public_network_access_enabled = true
  tags                          = var.tags
}

resource "azurerm_redis_firewall_rule" "allowed_ip_ranges" {
  for_each = var.allowed_ip_ranges

  name                = each.key
  redis_cache_name    = azurerm_redis_cache.this.name
  resource_group_name = var.resource_group_name
  start_ip            = each.value.start_ip
  end_ip              = each.value.end_ip
}
