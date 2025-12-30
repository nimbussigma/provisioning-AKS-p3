output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "subnet_system_id" {
  value = module.network.subnet_system_id
}

output "subnet_workload_id" {
  value = module.network.subnet_workload_id
}

output "subnet_bastion_vm_id" {
  value = module.network.subnet_bastion_vm_id
}

output "subnet_azure_bastion_id" {
  value = module.network.subnet_azure_bastion_id
}

output "route_table_id" {
  value = module.network.route_table_id
}

output "nat_gateway_id" {
  value = module.network.nat_gateway_id
}
