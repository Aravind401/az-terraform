# Azure User-Assigned Managed Identity

This folder is a standalone Terraform root configuration. It creates a
user-assigned managed identity in an existing resource group.

Creating the identity does not grant it access to Azure resources. Assign
appropriate Azure RBAC roles separately, and attach the identity to the
workload that needs it. The identity can be used independently of a specific
compute resource.

## Files and configuration

- `main.tf` defines the user-assigned managed identity.
- `variables.tf` declares the resource group, region, identity name, and tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars` and update the name and region. The real `.tfvars` file
  is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the identity resource ID, client ID, and principal ID.

## Run from PowerShell

Run these commands from this folder and create the local variable file first:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\managedidentity"
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

The service principal needs permission to create user-assigned managed
identities in the target resource group. Keep credentials and Terraform state
secure; do not commit credentials or secret values. Configure a secure remote
backend for team or production use.

## Use as a child module

Configure the AzureRM provider in the root configuration and pass this
folder's inputs from the root module:

```hcl
module "managedidentity" {
  source = "./managedidentity"

  resource_group_name   = "rg-app-prod"
  location              = "swedencentral"
  managed_identity_name = "id-app-prod"
}
```
