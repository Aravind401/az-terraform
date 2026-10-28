# Microsoft Foundry

This folder is a standalone Terraform root configuration. It creates an Azure
AI Services account of kind `AIServices`, the current account resource used
with Microsoft Foundry, in an existing resource group. Project management is
enabled so Foundry projects can be created under the account. The account is
configured with a system-assigned managed identity and Microsoft Entra
authentication; local API key authentication is disabled by default.

The account name and custom subdomain must be globally unique. Ensure the
selected region supports the models and Foundry features you intend to use.
This configuration creates the Foundry account, not a project or model
deployment.

## Files and configuration

- `main.tf` defines the Foundry account.
- `variables.tf` declares the resource group, region, account name, custom
  subdomain, SKU, authentication and network settings, and tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars` and update the names and region. The real `.tfvars` file
  is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the account ID, name, endpoint, and managed identity
  principal ID.

## Run from PowerShell

Run these commands from this folder and create the local variable file first:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\aifoundry"
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

The service principal needs permission to create Cognitive Services accounts
in the target resource group. Keep credentials and Terraform state secure; do
not commit credentials or secret values. Configure a secure remote backend for
team or production use.

## Use as a child module

Configure the AzureRM provider in the root configuration and pass this
folder's inputs from the root module:

```hcl
module "aifoundry" {
  source = "./aifoundry"

  resource_group_name   = "rg-app-prod"
  location              = "swedencentral"
  foundry_name          = "foundry-app-prod-unique"
  custom_subdomain_name = "foundry-app-prod-unique"
}
```
