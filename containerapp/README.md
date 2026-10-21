# Azure Container App

This folder is a standalone Terraform root configuration. It creates a
Container Apps managed environment and deploys one containerized application
with HTTP ingress. The default ingress is externally accessible; set
`external_ingress_enabled` to `false` to limit ingress to the environment.

The resource group must already exist. The example deploys Microsoft's
Container Apps hello-world image on port 80. An existing Log Analytics
workspace and a delegated infrastructure subnet can optionally be supplied.
The subnet must meet Azure Container Apps environment requirements and be
delegated to `Microsoft.App/environments`.

## Files and configuration

- `main.tf` defines the managed environment and Container App.
- `variables.tf` declares the image, ingress, scale, compute, environment
  variable, optional logging/network integration, and tag inputs.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars` and update them for your environment. The real `.tfvars`
  file is ignored by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the app ID, name, environment ID, latest revision name,
  and ingress FQDN.

Do not pass secrets using `environment_variables`: values are stored in
Terraform state. For secrets, configure Container App secrets and secret
references, and protect the state file. For team or production use, configure
a secure remote backend.

## Run from PowerShell

Run these commands from this folder so Terraform automatically loads
`terraform.tfvars`. Create that local file from the checked-in example first:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\containerapp"
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

The service principal needs permission to create Container Apps resources in
the target resource group and access any optional Log Analytics workspace or
subnet. Do not commit credentials to Terraform files or source control. After
Terraform finishes, remove the credentials from the current PowerShell
session:

```powershell
Remove-Item Env:ARM_SUBSCRIPTION_ID, Env:ARM_TENANT_ID, Env:ARM_CLIENT_ID, Env:ARM_CLIENT_SECRET
```

## Use as a child module

This folder can also be called from another Terraform root configuration:

```hcl
module "containerapp" {
  source = "./containerapp"

  resource_group_name            = "rg-app-demo"
  location                       = "swedencentral"
  container_app_environment_name = "cae-app-prod"
  container_app_name             = "ca-app-prod"
  container_image                = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
  target_port                    = 80
}
```

When using it as a child module, Terraform reads variable values from the root
configuration's `.tfvars` file, not from `containerapp/terraform.tfvars.example`.
Configure the AzureRM provider in the root configuration and pass module
inputs there.
