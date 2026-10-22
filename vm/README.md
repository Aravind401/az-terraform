# Azure Linux Virtual Machine

This folder is a standalone Terraform root configuration. It creates a Linux
virtual machine using the `Standard_B2ats_v2` size, an x64 general-purpose
size with 2 vCPUs and 4 GiB of memory. The VM uses Canonical Ubuntu 22.04 LTS
x64 Gen2, a dedicated virtual network and subnet, a Standard public IP, and
an NSG rule that permits SSH only from a configured IPv4 CIDR. Password
authentication is disabled; configure an OpenSSH public key to log in.

The resource group must already exist. VM size, image, and public IP
availability depend on the selected region and subscription quota. Check
regional availability before applying.

## Files and configuration

- `main.tf` defines the VM, dedicated VNet/subnet, public IP, NIC, and network
  security group with restricted SSH ingress.
- `variables.tf` declares the resource names, address ranges, administrator
  key, and SSH source CIDR.
- `terraform.tfvars.example` provides example values. Copy it to
  `terraform.tfvars`, replace the placeholder public key and documentation
  IP/CIDR, and update the names and region. The real `.tfvars` file is ignored
  by Git.
- `provider.tf` configures the AzureRM provider.
- `versions.tf` declares the supported Terraform and AzureRM provider versions.
- `outputs.tf` exports the VM ID, name, public IP, SSH command, and network IDs.

Do not put a private key in Terraform configuration. The public IP exposes the
VM to the internet, but inbound SSH is restricted by the configured source
CIDR; use your current public IP as a `/32` prefix. Terraform state contains
infrastructure details, so protect it and use a secure remote backend for team
or production deployments.

## Create an SSH key pair

In PowerShell, check whether you already have an SSH key pair:

```powershell
Get-ChildItem "$HOME\.ssh"
```

If you have a key you want to use, set `$publicKeyPath` to its `.pub` file
(for example, `"$HOME\.ssh\id_ed25519.pub"`) and skip key generation. Otherwise,
create a dedicated Ed25519 key pair:

```powershell
ssh-keygen -t ed25519 -a 100 -f "$HOME\.ssh\azure_vm" -C "azure-vm"
```

When prompted, optionally enter a passphrase to protect the private key. This
creates a private key at `$HOME\.ssh\azure_vm` and its public key at
`$HOME\.ssh\azure_vm.pub`. Never share or upload the private key. If
`ssh-keygen` is not recognized, install the Windows **OpenSSH Client**
optional feature, then reopen PowerShell.

Set the public-key path and display its single-line content:

```powershell
$publicKeyPath = "$HOME\.ssh\azure_vm.pub"
(Get-Content $publicKeyPath -Raw).Trim()
```

Copy that output (it starts with `ssh-ed25519`) into the local
`terraform.tfvars`, replacing the placeholder on the `admin_ssh_public_key`
line. Keep it quoted, for example:

```hcl
admin_ssh_public_key = "ssh-ed25519 AAAA... azure-vm"
```

Only the `.pub` key belongs in Terraform configuration. The matching private
key stays on your computer and is used by the SSH client to connect after
deployment.

## Run from PowerShell

Create a local `terraform.tfvars` from the example and update its placeholder
values, including the SSH public key and your public IP/CIDR, before planning:

```powershell
Set-Location "C:\Users\aravi\OneDrive\Desktop\az-terraform\vm"
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

# Apply only after reviewing the plan. Terraform asks for confirmation.
terraform apply
```

The service principal needs permission to create virtual machines, networking
resources, and public IP addresses in the target resource group. Remove
credentials from the current PowerShell session after use:

```powershell
Remove-Item Env:ARM_SUBSCRIPTION_ID, Env:ARM_TENANT_ID, Env:ARM_CLIENT_ID, Env:ARM_CLIENT_SECRET
```

## Use as a child module

The configuration can also be called from another Terraform root:

```hcl
module "vm" {
  source = "./vm"

  resource_group_name         = "rg-app-prod"
  location                    = "swedencentral"
  virtual_machine_name        = "vm-app-prod"
  computer_name               = "vm-app-prod"
  network_security_group_name = "nsg-vm-app-prod"
  public_ip_name              = "pip-vm-app-prod"
  network_interface_name      = "nic-vm-app-prod"
  admin_ssh_public_key        = file("~/.ssh/id_ed25519.pub")
  ssh_source_address_prefix   = "YOUR_PUBLIC_IP/32"
}
```

When used as a child module, configure the AzureRM provider and provide values
from the root configuration; Terraform does not load this folder's example
tfvars automatically.
