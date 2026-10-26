# Azure Container Registry

This folder is a standalone Terraform root configuration. It creates an
Azure Container Registry in an existing resource group. The registry admin
account is disabled by default; authenticate with Microsoft Entra ID instead.

The registry name must be globally unique and contain only letters and
numbers. Basic is the default SKU; choose Standard or Premium when you need
their additional capacity and features.

## Files and configuration

- `main.tf` defines the Container Registry.
- `variables.tf` declares the resource group, region, registry name, SKU,
  admin-account setting, and tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars` and update the name and region. The real `.tfvars` file
  is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the registry ID, name, and login server.

## Run from PowerShell

Run these commands from this folder and create the local variable file first:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\containerregistry"
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

The service principal needs permission to create Container Registries in the
target resource group. Keep credentials and Terraform state secure; do not
commit credentials or secret values. Configure a secure remote backend for
team or production use.

## Use as a child module

Configure the AzureRM provider in the root configuration and pass this
folder's inputs from the root module:

```hcl
module "containerregistry" {
  source = "./containerregistry"

  resource_group_name     = "rg-app-prod"
  location                = "swedencentral"
  container_registry_name = "acrappprodunique"
}
```
