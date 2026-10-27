# Azure Database for PostgreSQL

This folder is a standalone Terraform root configuration. It creates an
Azure Database for PostgreSQL Flexible Server and a database in an existing
resource group. Public network access is enabled, but the server firewall
allows only the ranges explicitly listed in `allowed_ip_ranges`; an empty
map denies client IP access.

The server name must be globally unique. The default `B_Standard_B2s` SKU has
2 vCores and 4 GiB of memory and is intended for a small development example;
confirm regional availability and sizing before deployment. Azure capacity
can vary by region and time. If allocation fails for a SKU, choose another
available size or region and review any cost and performance changes. The
administrator password and Terraform state are sensitive. Use a secure remote
backend for team or production use.

## Files and configuration

- `main.tf` defines the server, database, and optional firewall rules.
- `variables.tf` declares server settings, credentials, firewall ranges, and
  tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars`, replace the password and example IP address, and update
  the names and region. The real `.tfvars` file is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the server ID and hostname and database name; it does
  not expose the administrator password.

## Run from PowerShell

Run these commands from this folder after updating the local variable file:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\postgresql"
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

Replace the example password with a strong secret and use your actual public
client IP for the firewall range. Do not commit credentials or secret values.
The service principal needs permission to create PostgreSQL resources in the
target resource group.

## Use as a child module

Configure the AzureRM provider in the calling root and pass the module inputs:

```hcl
module "postgresql" {
  source = "./postgresql"

  resource_group_name    = "rg-app-prod"
  location               = "swedencentral"
  server_name            = "pg-app-prod-unique"
  administrator_password = var.postgresql_administrator_password
  allowed_ip_ranges = {
    application = {
      start_ip_address = "10.0.1.10"
      end_ip_address   = "10.0.1.10"
    }
  }
}
```

When used as a child module, provide values from the root configuration;
Terraform does not load this folder's example tfvars automatically.
