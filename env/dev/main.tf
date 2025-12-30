locals {
  tags = {
    project = var.project
    env     = var.env
  }

  name_prefix = "${var.project}-${var.env}"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.tags
}

module "network" {
  source = "../../modules/network"

  name_prefix               = local.name_prefix
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  tags                      = local.tags
  vnet_cidr                 = var.vnet_cidr
  subnet_system_cidr        = var.subnet_system_cidr
  subnet_workload_cidr      = var.subnet_workload_cidr
  subnet_bastion_vm_cidr    = var.subnet_bastion_vm_cidr
  subnet_azure_bastion_cidr = var.subnet_azure_bastion_cidr
}

module "bastion" {
  source = "../../modules/bastion"

  name_prefix         = local.name_prefix
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = module.network.subnet_bastion_vm_id
  admin_username      = var.admin_username
  tags                = local.tags
}
