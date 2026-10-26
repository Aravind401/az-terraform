# Azure Key Vault

This folder is a standalone Terraform root configuration. It creates an
Azure Key Vault in an existing resource group with Azure RBAC authorization,
soft delete, and purge protection enabled.

The vault name must be globally unique, 3-24 characters, and contain only
letters, numbers, and hyphens. The example tenant ID is a placeholder; replace
it with the Microsoft Entra tenant ID for your subscription. Grant users,
applications, or managed identities the required data-plane roles separately
using Azure RBAC.

## Files and configuration

- `main.tf` defines the Key Vault.
- `variables.tf` declares the resource group, region, tenant ID, vault name,
  SKU, soft-delete retention, purge-protection setting, and tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars` and update the tenant ID, vault name, and region. The real
  `.tfvars` file is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions
  (AzureRM 4.0 or later).
- `outputs.tf` exports the Key Vault ID, name, and URI.

Terraform state can contain sensitive infrastructure data. Protect it, do not
commit credentials or secret values, and configure a secure remote backend for
team or production use.

## Run from PowerShell

Run these commands from this folder and create the local variable file first:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\keyvault"
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

The service principal needs permission to create Key Vaults in the target
resource group. Remove the credentials from the current PowerShell session
when finished:

```powershell
Remove-Item Env:ARM_SUBSCRIPTION_ID, Env:ARM_TENANT_ID, Env:ARM_CLIENT_ID, Env:ARM_CLIENT_SECRET
```

## Use as a child module

Configure the AzureRM provider in the root configuration and pass this
folder's inputs from the root module:

```hcl
module "keyvault" {
  source = "./keyvault"

  resource_group_name = "rg-app-prod"
  location            = "swedencentral"
  tenant_id           = "YOUR_TENANT_ID"
  key_vault_name      = "kv-app-prod-unique"
}
```
