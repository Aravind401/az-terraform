# Azure network

This folder is a standalone Terraform root configuration. It creates an Azure
virtual network and five purpose-specific subnets:

- Container Apps (`Microsoft.App/environments` delegation)
- Web Apps (`Microsoft.Web/serverFarms` delegation)
- Function App (`Microsoft.Web/serverFarms` delegation)
- Database
- Other services

The resource group must already exist. The default virtual network address
space is `10.0.0.0/16`, with a `/24` prefix per subnet. Choose ranges that fit
your network plan, do not overlap, and meet the requirements of the Azure
services you plan to deploy.

## Files and configuration

- `main.tf` defines the virtual network and creates the five subnets. It adds
  Azure service delegations to the Container Apps, Web Apps, and Function App
  subnets.
- `variables.tf` declares the input values, types, and default address ranges.
- `terraform.tfvars.example` provides example values for the resource group,
  region, VNet name, and address ranges. Copy it to `terraform.tfvars` and
  update those values for your environment. The real `.tfvars` file is ignored
  by Git because it may contain sensitive values.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the virtual network ID and name, and subnet IDs and
  names.

## Run from PowerShell

Run these commands from this folder so Terraform automatically loads
`terraform.tfvars`. Create that local file from the checked-in example first:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\network"
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
The service principal needs permission to create virtual networks and subnets
in the target resource group. Do not commit credentials to Terraform files or
source control. After Terraform finishes, remove the credentials from the
current PowerShell session:

```powershell
Remove-Item Env:ARM_SUBSCRIPTION_ID, Env:ARM_TENANT_ID, Env:ARM_CLIENT_ID, Env:ARM_CLIENT_SECRET
```

Terraform stores state in this folder by default. Keep the state file secure;
for team or production use, configure a secure remote backend.

## Use as a child module

This folder can also be called from another Terraform root configuration:

```hcl
module "network" {
  source = "./network"

  resource_group_name  = "rg-app-prod"
  location             = "eastus"
  virtual_network_name = "vnet-app-prod"

  address_space = ["10.20.0.0/16"]
  subnet_address_prefixes = {
    container_apps = "10.20.1.0/24"
    web_apps       = "10.20.2.0/24"
    function_app   = "10.20.3.0/24"
    database       = "10.20.4.0/24"
    other_services = "10.20.5.0/24"
  }
}
```

When using it as a child module, Terraform reads variable values from the root
configuration's `.tfvars` file, not from `network/terraform.tfvars.example`.
Configure the AzureRM provider in the root configuration and pass the module
inputs there.
