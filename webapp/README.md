# Azure web app

This folder is a standalone Terraform root configuration. It creates a Linux
App Service Plan and a Linux Web App configured to use the Node.js runtime.
The app is HTTPS-only. It does not integrate with the network in the `network`
folder; this keeps the Web App configuration independent.

The resource group must already exist, and the Web App name must be globally
unique across Azure. The default plan SKU is `B1`, which supports always-on.
The example uses the `F1` SKU with always-on disabled. Quota and SKU
availability depend on the subscription and region; selecting Sweden Central
does not guarantee that a requested SKU has available quota there.

## Files and configuration

- `main.tf` defines the Linux App Service Plan and Node.js Web App.
- `variables.tf` declares the inputs and defaults, including Node.js version,
  plan SKU, always-on behavior, app settings, and tags.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars` and update the names and region for your environment. The
  real `.tfvars` file is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the Web App ID, name, default hostname, and plan ID.

App settings can contain secrets. Terraform stores them in state, so protect
the state file and never commit credentials or secret values.

## Run from PowerShell

Run these commands from this folder so Terraform automatically loads
`terraform.tfvars`. Create that local file from the checked-in example first:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\webapp"
Copy-Item .\terraform.tfvars.example .\terraform.tfvars

# Authenticate the AzureRM provider with a service principal.
# Replace each placeholder with the values from your Azure environment.
$env:ARM_SUBSCRIPTION_ID = "YOUR_SUBSCRIPTION_ID"
$env:ARM_TENANT_ID       = "YOUR_TENANT_ID"
$env:ARM_CLIENT_ID       = "YOUR_CLIENT_ID"
$env:ARM_CLIENT_SECRET   = "YOUR_CLIENT_SECRET"

# Download provider plugins and initialize the working directory.
terraform init

# Check the configuration and preview the changes.
terraform validate
terraform plan

# Apply the configuration. Terraform asks for confirmation.
terraform apply

# Optional: apply without an interactive confirmation prompt.
# Use only when you have reviewed the plan.
terraform apply -auto-approve
```

PowerShell uses `$env:VARIABLE` to set environment variables for the current
PowerShell session; `export` is the equivalent syntax in shells such as Bash.
The service principal needs permission to create App Service resources in the
target resource group. Do not commit credentials to Terraform files or source
control. After Terraform finishes, remove the credentials from the current
PowerShell session:

```powershell
Remove-Item Env:ARM_SUBSCRIPTION_ID, Env:ARM_TENANT_ID, Env:ARM_CLIENT_ID, Env:ARM_CLIENT_SECRET
```

Terraform stores state in this folder by default. Keep the state file secure;
for team or production use, configure a secure remote backend.

## Use as a child module

This folder can also be called from another Terraform root configuration:

```hcl
module "webapp" {
  source = "./webapp"

  resource_group_name   = "rg-app-prod"
  location              = "swedencentral"
  web_app_name          = "app-prod-web-unique"
  app_service_plan_name = "asp-app-prod"
  node_version          = "20-lts"
  sku_name              = "B1"
  always_on             = true
}
```

When using it as a child module, Terraform reads variable values from the root
configuration's `.tfvars` file, not from `webapp/terraform.tfvars.example`.
Configure the AzureRM provider in the root configuration and pass module
inputs there.
