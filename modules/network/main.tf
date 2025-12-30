resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]
  tags                = var.tags
}

resource "azurerm_subnet" "subnet_system" {
  name                 = "snet-aks-system"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_system_cidr]
}

resource "azurerm_subnet" "subnet_workload" {
  name                 = "snet-aks-workload"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_workload_cidr]
}

resource "azurerm_subnet" "subnet_bastion_vm" {
  name                 = "snet-bastion-vm"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_bastion_vm_cidr]
}

resource "azurerm_subnet" "subnet_azure_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_azure_bastion_cidr]
}

# Azure Bastion
resource "azurerm_public_ip" "bastion_pip" {
  name                = "pip-bastion-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags                = var.tags

  ip_configuration {
    name                 = "bastion-ipcfg"
    subnet_id            = azurerm_subnet.subnet_azure_bastion.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}

# NAT Gateway (outbound)
resource "azurerm_public_ip" "nat_pip" {
  name                = "pip-nat-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway" "nat" {
  name                = "nat-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat.id
  public_ip_address_id = azurerm_public_ip.nat_pip.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_system" {
  subnet_id      = azurerm_subnet.subnet_system.id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_workload" {
  subnet_id      = azurerm_subnet.subnet_workload.id
  nat_gateway_id = azurerm_nat_gateway.nat.id
}

# UDR route table (required by task; will be used with AKS outbound_type=userDefinedRouting)
resource "azurerm_route_table" "rt_aks" {
  name                = "rt-aks-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_route_table_association" "rt_system" {
  subnet_id      = azurerm_subnet.subnet_system.id
  route_table_id = azurerm_route_table.rt_aks.id
}

resource "azurerm_subnet_route_table_association" "rt_workload" {
  subnet_id      = azurerm_subnet.subnet_workload.id
  route_table_id = azurerm_route_table.rt_aks.id
}
