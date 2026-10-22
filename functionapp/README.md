# Azure Function App

This folder is a standalone Terraform root configuration. It creates a
Linux Consumption App Service Plan, a Linux Function App configured for
Node.js, and the storage account required by Azure Functions. The Function
App is HTTPS-only.

The resource group must already exist. The Function App and storage account
names must be globally unique; storage account names must be 3-24 lowercase
letters or digits. The default plan SKU is `Y1`; SKU availability depends on
the subscription and region.

Terraform provisions the Function App host but does not deploy function
source code. Deploy your function package separately using your preferred
Azure Functions deployment workflow.

## Files and configuration

- `main.tf` defines the storage account, Linux App Service Plan, and Function
  App.
- `variables.tf` declares the resource names, Node.js version, plan SKU,
  additional application settings, and tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars` and update the names and region for your environment. The
  real `.tfvars` file is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the Function App ID, name, hostname, plan ID, and
  storage account ID.

Terraform stores the storage account key and application settings in state.
Protect the state file, do not pass secrets unless necessary, and never commit
credentials or secret values. For team or production use, configure a secure
remote backend.

## Run from PowerShell

Run these commands from this folder so Terraform automatically loads
`terraform.tfvars`. Create that local file from the checked-in example first:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\functionapp"
Copy-Item .\terraform.tfvars.example .\terraform.tfvars

# Authenticate the AzureRM provider with a service principal.
# Replace each placeholder with the values from your Azure environment.
$env:ARM_SUBSCRIPTION_ID = "YOUR_SUBSCRIPTION_ID"
$env:ARM_TENANT_ID       = "YOUR_TENANT_ID"
$env:ARM_CLIENT_ID       = "YOUR_CLIENT_ID"
$env:ARM_CLIENT_SECRET   = "YOUR_CLIENT_SECRET"

terraform init
terraform validate
terraform plan

# Apply the configuration. Terraform asks for confirmation.
terraform apply
```

The service principal needs permission to create Function Apps, App Service
Plans, and storage accounts in the target resource group. Do not commit
credentials to Terraform files or source control. After Terraform finishes,
remove the credentials from the current PowerShell session:

```powershell
Remove-Item Env:ARM_SUBSCRIPTION_ID, Env:ARM_TENANT_ID, Env:ARM_CLIENT_ID, Env:ARM_CLIENT_SECRET
```

## Use as a child module

This folder can also be called from another Terraform root configuration:

```hcl
module "functionapp" {
  source = "./functionapp"

  resource_group_name  = "rg-app-prod"
  location             = "swedencentral"
  function_app_name     = "func-app-prod-unique"
  app_service_plan_name = "asp-func-app-prod"
  storage_account_name = "stfuncappprodunique"
  node_version         = "20"
}
```

When using it as a child module, Terraform reads variable values from the root
configuration's `.tfvars` file, not from `functionapp/terraform.tfvars.example`.
Configure the AzureRM provider in the root configuration and pass module
inputs there.
