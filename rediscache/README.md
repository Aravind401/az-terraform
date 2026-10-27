# Azure Managed Redis

This folder is a standalone Terraform root configuration. It creates an
Azure Managed Redis instance in an existing resource group using the smallest
Balanced SKU, `Balanced_B0`.

This configuration replaces the retired `azurerm_redis_cache` resource.
Azure rejects new Azure Cache for Redis deployments and directs customers to
Azure Managed Redis. The old `Basic`, `Standard`, and `Premium` SKU values
are not valid for this service.

The default database enforces encrypted client connections and disables
access-key authentication. Microsoft Entra ID authentication is used instead;
grant the calling application's identity the appropriate Redis data access
permissions. Public network access is enabled for this example, so the
endpoint is reachable over the network but still requires authentication.
For production, consider disabling public access and configuring private
connectivity.

## Files and configuration

- `main.tf` defines the Managed Redis instance and encrypted default database.
- `variables.tf` declares the resource group, region, supported SKU, and tags.
- `terraform.tfvars` contains local values for this deployment and is ignored
  by Git. Use `Balanced_B0` or another supported Managed Redis SKU; `Basic`
  is not a valid value.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the required Terraform and AzureRM provider versions.
- `outputs.tf` exports the cache ID, hostname, and TLS port; it does not expose
  access keys.

## Run from PowerShell

Run these commands from this folder after updating the local variable file:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\rediscache"

$env:ARM_SUBSCRIPTION_ID = "YOUR_SUBSCRIPTION_ID"
$env:ARM_TENANT_ID       = "YOUR_TENANT_ID"
$env:ARM_CLIENT_ID       = "YOUR_CLIENT_ID"
$env:ARM_CLIENT_SECRET   = "YOUR_CLIENT_SECRET"

terraform init -upgrade
terraform validate
terraform plan
terraform apply
```

The Azure Managed Redis service is available only in selected regions and
requires the Microsoft.Cache provider. Confirm SKU and regional availability
for your subscription before applying. Protect Terraform state and use a
secure remote backend for team or production use.

## Use as a child module

Configure the AzureRM provider in the calling root and pass the module inputs:

```hcl
module "rediscache" {
  source = "./rediscache"

  resource_group_name = "rg-app-prod"
  location            = "swedencentral"
  cache_name          = "redis-app-prod"
  sku_name            = "Balanced_B0"
}
```

When used as a child module, provide values from the root configuration;
Terraform does not load this folder's local tfvars automatically.
