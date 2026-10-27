# Azure Service Bus

This folder is a standalone Terraform root configuration. It creates an
Azure Service Bus namespace and a queue in an existing resource group. The
namespace enforces TLS 1.2 and uses the Standard SKU by default.

The namespace name must be globally unique. This example does not export
connection strings or keys; use Microsoft Entra ID and assign appropriate
Azure Service Bus data-plane roles to applications instead of storing shared
access keys in source control.

## Files and configuration

- `main.tf` defines the namespace and queue.
- `variables.tf` declares the resource group, region, namespace, queue, SKU,
  and tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars` and update the namespace name and region. The real
  `.tfvars` file is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports resource IDs and names, but no access keys.

## Run from PowerShell

Run these commands from this folder after updating the local variable file:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\servicebus"
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

The service principal needs permission to create Service Bus resources in the
target resource group. Protect Terraform state and use a secure remote backend
for team or production use.

## Use as a child module

Configure the AzureRM provider in the calling root and pass the module inputs:

```hcl
module "servicebus" {
  source = "./servicebus"

  resource_group_name = "rg-app-prod"
  location            = "swedencentral"
  namespace_name      = "sb-app-prod-unique"
  queue_name          = "orders"
}
```

When used as a child module, Terraform does not load this folder's example
tfvars automatically.
