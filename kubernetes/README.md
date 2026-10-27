# Azure Kubernetes Service (AKS)

This folder is a standalone Terraform root configuration. It creates an AKS
cluster with a system-assigned identity, Azure CNI Overlay networking with
Cilium, Kubernetes RBAC, Azure Policy, and a single-node system pool for a
small example deployment.

The cluster exposes a public API endpoint restricted to the CIDR ranges in
`api_server_authorized_ip_ranges`. At least one trusted CIDR is required.
Replace the documentation-only address in the example with your public IP
address in CIDR form (usually `/32`) before applying. Node size and quota
availability vary by region and subscription.

## Files and configuration

- `main.tf` defines the AKS cluster, node pool, identity, and network profile.
- `variables.tf` declares cluster settings, API server allow-ranges, and tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars`, replace the API server CIDR, and update the names and
  region. The real `.tfvars` file is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the cluster ID, name, hostname, and credentials command.

## Run from PowerShell

Run these commands from this folder after replacing the example CIDR:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\kubernetes"
Copy-Item .\terraform.tfvars.example .\terraform.tfvars

$env:ARM_SUBSCRIPTION_ID = "YOUR_SUBSCRIPTION_ID"
$env:ARM_TENANT_ID       = "YOUR_TENANT_ID"
$env:ARM_CLIENT_ID       = "YOUR_CLIENT_ID"
$env:ARM_CLIENT_SECRET   = "YOUR_CLIENT_SECRET"

terraform init
terraform validate
terraform plan
terraform apply
```

The service principal needs permission to create AKS and its managed network
resources in the target resource group. After deployment, retrieve credentials
with the `get_credentials_command` output. Terraform state contains resource
details; protect it and configure a secure remote backend for team or
production use.

## Use as a child module

Configure the AzureRM provider in the calling root and provide values there:

```hcl
module "kubernetes" {
  source = "./kubernetes"

  resource_group_name                = "rg-app-prod"
  location                           = "swedencentral"
  cluster_name                       = "aks-app-prod"
  dns_prefix                         = "aks-app-prod"
  api_server_authorized_ip_ranges    = ["YOUR_PUBLIC_IP/32"]
}
```

When used as a child module, Terraform does not load this folder's example
tfvars automatically.
