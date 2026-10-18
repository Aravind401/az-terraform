output "virtual_network_id" {
  description = "ID of the created virtual network."
  value       = azurerm_virtual_network.this.id
}

output "virtual_network_name" {
  description = "Name of the created virtual network."
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "IDs of the created subnets, keyed by purpose."
  value       = { for key, subnet in azurerm_subnet.this : key => subnet.id }
}

output "subnet_names" {
  description = "Names of the created subnets, keyed by purpose."
  value       = { for key, subnet in azurerm_subnet.this : key => subnet.name }
}
