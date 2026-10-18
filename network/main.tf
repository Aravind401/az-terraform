locals {
  subnet_names = {
    container_apps = "snet-container-apps"
    web_apps       = "snet-web-apps"
    function_app   = "snet-function-app"
    database       = "snet-database"
    other_services = "snet-other-services"
  }

  subnet_delegations = {
    container_apps = {
      name = "Microsoft.App.environments"
      service_delegation = {
        name    = "Microsoft.App/environments"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    }
    web_apps = {
      name = "Microsoft.Web.serverFarms"
      service_delegation = {
        name    = "Microsoft.Web/serverFarms"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
    function_app = {
      name = "Microsoft.Web.serverFarms"
      service_delegation = {
        name    = "Microsoft.Web/serverFarms"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }

  subnets = {
    for key, name in local.subnet_names : key => {
      name             = name
      address_prefixes = [var.subnet_address_prefixes[key]]
    }
  }
}

resource "azurerm_virtual_network" "this" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

resource "azurerm_subnet" "this" {
  for_each = local.subnets

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes

  dynamic "delegation" {
    for_each = contains(keys(local.subnet_delegations), each.key) ? [local.subnet_delegations[each.key]] : []
    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }
}
