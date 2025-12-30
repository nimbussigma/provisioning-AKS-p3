locals {
  tags = {
    project = var.project
    env     = var.env
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.tags
}
