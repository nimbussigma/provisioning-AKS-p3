variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for bastion VM (private subnet)"
}

variable "admin_username" {
  type        = string
  description = "Admin username for VM"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
}

variable "name_prefix" {
  type        = string
  description = "Prefix for resource names"
}
