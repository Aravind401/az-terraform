output "cluster_id" {
  description = "ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.id
}

output "cluster_name" {
  description = "Name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.name
}

output "cluster_fqdn" {
  description = "Fully qualified API server hostname."
  value       = azurerm_kubernetes_cluster.this.fqdn
}

output "get_credentials_command" {
  description = "Azure CLI command to add the cluster credentials to the local kubeconfig."
  value       = "az aks get-credentials --resource-group ${var.resource_group_name} --name ${azurerm_kubernetes_cluster.this.name}"
}
