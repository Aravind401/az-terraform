variable "resource_group_name" {
  description = "Name of the existing resource group for the VM resources."
  type        = string
}

variable "location" {
  description = "Azure region in which to create the VM resources."
  type        = string
}

variable "virtual_machine_name" {
  description = "Name of the Linux virtual machine."
  type        = string
}

variable "computer_name" {
  description = "Host name configured inside the Linux virtual machine (maximum 64 characters)."
  type        = string
}

variable "vm_size" {
  description = "Azure VM size. B2ats_v2 is an Arm-based, 2-vCPU, 4-GiB general-purpose size."
  type        = string
  default     = "Standard_B2ats_v2"
}

variable "admin_username" {
  description = "Non-root Linux administrator account name."
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "OpenSSH public key used for VM login. Never supply a private key."
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the dedicated virtual network."
  type        = string
}

variable "virtual_network_address_space" {
  description = "CIDR address space for the dedicated virtual network."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the VM subnet."
  type        = string
  default     = "snet-vm"
}

variable "subnet_address_prefixes" {
  description = "CIDR address prefixes for the VM subnet."
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

variable "network_security_group_name" {
  description = "Name of the network security group attached to the VM interface."
  type        = string
}

variable "public_ip_name" {
  description = "Name of the VM public IP address."
  type        = string
}

variable "network_interface_name" {
  description = "Name of the VM network interface."
  type        = string
}

variable "ssh_source_address_prefix" {
  description = "IPv4 CIDR allowed to connect to TCP port 22, such as your public IP with a /32 suffix."
  type        = string

  validation {
    condition     = can(cidrhost(var.ssh_source_address_prefix, 0)) && var.ssh_source_address_prefix != "0.0.0.0/0"
    error_message = "Provide a valid IPv4 CIDR and do not allow SSH from 0.0.0.0/0."
  }
}

variable "tags" {
  description = "Tags to apply to the VM and its network resources."
  type        = map(string)
  default     = {}
}
