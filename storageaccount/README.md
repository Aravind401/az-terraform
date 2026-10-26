# Azure Storage Account

This folder is a standalone Terraform root configuration. It creates an
Azure Storage Account in an existing resource group with HTTPS-only traffic,
TLS 1.2 or later, and anonymous access to containers and blobs disabled.

Storage Account names must be globally unique and contain 3-24 lowercase
letters or numbers. The default is a Standard StorageV2 account with
locally-redundant storage (LRS). Choose a replication type and tier supported
by the selected account kind and Azure region.

## Files and configuration

- `main.tf` defines the Storage Account and its security settings.
- `variables.tf` declares the resource group, region, account name, tier,
  replication type, kind, minimum TLS version, and tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars` and update the name and region. The real `.tfvars` file
  is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the account ID, name, and primary blob endpoint.

Terraform state may contain sensitive infrastructure data. Protect it, do not
commit credentials or secret values, and configure a secure remote backend for
team or production use.

## Run from PowerShell

Run these commands from this folder and create the local variable file first:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\storageaccount"
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

The service principal needs permission to create Storage Accounts in the
target resource group. Keep credentials and Terraform state secure; do not
commit credentials or secret values. Configure a secure remote backend for
team or production use.

## Use as a child module

Configure the AzureRM provider in the root configuration and pass this
folder's inputs from the root module:

```hcl
module "storageaccount" {
  source = "./storageaccount"

  resource_group_name  = "rg-app-prod"
  location             = "swedencentral"
  storage_account_name = "stappprodunique"
}
```
