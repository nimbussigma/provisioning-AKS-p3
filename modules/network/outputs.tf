output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_system_id" {
  value = azurerm_subnet.subnet_system.id
}

output "subnet_workload_id" {
  value = azurerm_subnet.subnet_workload.id
}

output "subnet_bastion_vm_id" {
  value = azurerm_subnet.subnet_bastion_vm.id
}

output "subnet_azure_bastion_id" {
  value = azurerm_subnet.subnet_azure_bastion.id
}

output "route_table_id" {
  value = azurerm_route_table.rt_aks.id
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.nat.id
}
