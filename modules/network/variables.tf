variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
}

variable "vnet_cidr" {
  type        = string
  description = "VNet CIDR"
}

variable "subnet_system_cidr" {
  type        = string
  description = "AKS system subnet CIDR"
}

variable "subnet_workload_cidr" {
  type        = string
  description = "AKS workload subnet CIDR"
}

variable "subnet_bastion_vm_cidr" {
  type        = string
  description = "Private subnet CIDR for bastion VM"
}

variable "subnet_azure_bastion_cidr" {
  type        = string
  description = "AzureBastionSubnet CIDR"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for resource names"
}
