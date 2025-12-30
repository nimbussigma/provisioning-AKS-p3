variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "project" {
  description = "Project tag value"
  type        = string
  default     = "provisioning-AKS-p3"
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "resource_group_name" {
  description = "Resource Group for AKS and networking"
  type        = string
  default     = "rg-aks-p3-dev"
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
  default     = "aks-p3-dev"
}

variable "vnet_cidr" {
  description = "CIDR for VNet"
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnet_system_cidr" {
  description = "CIDR for AKS system subnet"
  type        = string
  default     = "10.10.1.0/24"
}

variable "subnet_workload_cidr" {
  description = "CIDR for AKS workload subnet"
  type        = string
  default     = "10.10.2.0/24"
}

variable "subnet_bastion_vm_cidr" {
  description = "CIDR for private subnet where bastion VM lives"
  type        = string
  default     = "10.10.10.0/24"
}

variable "subnet_azure_bastion_cidr" {
  description = "CIDR for AzureBastionSubnet (required name)"
  type        = string
  default     = "10.10.20.0/27"
}

variable "admin_username" {
  description = "Admin username for the bastion VM"
  type        = string
  default     = "azureuser"
}
