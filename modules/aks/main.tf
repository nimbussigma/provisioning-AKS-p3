resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "dns-${var.name_prefix}"
  tags                = var.tags

  # Private API server
  private_cluster_enabled = true
  private_dns_zone_id = "System"
  

  # System node pool (private subnet)
  default_node_pool {
    name                 = "system"
    vm_size              = "Standard_DS2_v2"
    node_count           = 1
    vnet_subnet_id       = var.subnet_system_id
    orchestrator_version = null
    type                 = "VirtualMachineScaleSets"
  }

  # Managed identity (recommended)
  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"

    # IMPORTANT: task requirement
    outbound_type     = "userDefinedRouting"
  }
}

# Workload node pool in separate subnet
resource "azurerm_kubernetes_cluster_node_pool" "workload" {
  name                  = "workload"
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_D2s_v3"
  node_count            = 1
  vnet_subnet_id         = var.subnet_workload_id
  mode                  = "User"
  tags                  = var.tags
}
