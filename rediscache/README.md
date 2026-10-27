# Azure Cache for Redis

> **Retirement notice:** Microsoft plans to retire Azure Cache for Redis Basic,
> Standard, and Premium instances on September 30, 2028. Azure recommends
> migrating to Azure Managed Redis. This example is for deployments that
> specifically require the legacy Azure Cache for Redis service; choose Azure
> Managed Redis for new workloads where possible. See Microsoft's
> [retirement FAQ](https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/retirement-faq).

This folder is a standalone Terraform root configuration. It creates an Azure
Cache for Redis instance in an existing resource group and restricts client
access to the IP ranges explicitly listed in `allowed_ip_ranges`. At least
one range is required. TLS 1.2 is enforced and the non-TLS port is disabled.

The cache name must be globally unique. Basic C0 is used as a low-cost
development example; confirm SKU, capacity, and regional availability before
deployment. Firewall rules are IP-based and do not replace application
authentication. Terraform does not output the cache access keys.

## Files and configuration

- `main.tf` defines the Redis cache and firewall rules.
- `variables.tf` declares the resource group, region, SKU, capacity, client
  allow-ranges, and tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars`, replace the documentation-only IP address with your
  public client IP, and update the names and region. The real `.tfvars` file
  is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the cache ID, hostname, and TLS port; it does not expose
  access keys or connection strings.

## Run from PowerShell

Run these commands from this folder after updating the local variable file:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\rediscache"
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

Replace the example IP with your real public IP address. The service
principal needs permission to create Redis resources in the target resource
group. Protect Terraform state and use a secure remote backend for team or
production use.

## Use as a child module

Configure the AzureRM provider in the calling root and pass the module inputs:

```hcl
module "rediscache" {
  source = "./rediscache"

  resource_group_name = "rg-app-prod"
  location            = "swedencentral"
  cache_name          = "redis-app-prod-unique"
  allowed_ip_ranges = {
    application = {
      start_ip = "203.0.113.20"
      end_ip   = "203.0.113.20"
    }
  }
}
```

When used as a child module, Terraform does not load this folder's example
tfvars automatically.
