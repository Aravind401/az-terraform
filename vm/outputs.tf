output "virtual_machine_id" {
  description = "ID of the created Linux virtual machine."
  value       = azurerm_linux_virtual_machine.this.id
}

output "virtual_machine_name" {
  description = "Name of the created Linux virtual machine."
  value       = azurerm_linux_virtual_machine.this.name
}

output "public_ip_address" {
  description = "Public IPv4 address assigned to the VM."
  value       = azurerm_public_ip.this.ip_address
}

output "ssh_command" {
  description = "SSH command to connect to the VM using the corresponding private key."
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.this.ip_address}"
}

output "virtual_network_id" {
  description = "ID of the dedicated virtual network."
  value       = azurerm_virtual_network.this.id
}

output "subnet_id" {
  description = "ID of the VM subnet."
  value       = azurerm_subnet.this.id
}
