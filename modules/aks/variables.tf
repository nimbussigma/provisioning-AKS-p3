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

variable "name_prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "aks_name" {
  type        = string
  description = "AKS cluster name"
}

variable "subnet_system_id" {
  type        = string
  description = "Subnet ID for AKS system nodepool"
}

variable "subnet_workload_id" {
  type        = string
  description = "Subnet ID for AKS workload nodepool"
}
