# Azure AI Search

This folder is a standalone Terraform root configuration. It creates an Azure
AI Search service in an existing resource group. Microsoft Entra
authentication is enabled without API key authentication by default. Public
network access is enabled by default and can be disabled when using a private
endpoint configured separately.

The service name must be globally unique. The default `basic` SKU supports
production workloads; choose `free` for a limited development service or
another supported SKU as needed.

## Files and configuration

- `main.tf` defines the Search Service.
- `variables.tf` declares the resource group, region, service name, SKU,
  authentication and network settings, and tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars` and update the name and region. The real `.tfvars` file
  is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the service ID, name, and endpoint.

## Run from PowerShell

Run these commands from this folder and create the local variable file first:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\aisearch"
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

The service principal needs permission to create Search Services in the target
resource group. Keep credentials and Terraform state secure; do not commit
credentials or secret values. Configure a secure remote backend for team or
production use.

## Use as a child module

Configure the AzureRM provider in the root configuration and pass this
folder's inputs from the root module:

```hcl
module "aisearch" {
  source = "./aisearch"

  resource_group_name = "rg-app-prod"
  location            = "swedencentral"
  search_service_name = "search-app-prod-unique"
}
```
