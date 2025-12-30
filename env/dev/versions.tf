terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.50.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev"
    storage_account_name = "tfstate739827463"
    container_name       = "tfstate"
    key                  = "env/dev/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "8f5d747d-35bb-4727-838e-fbd5ad5a31b5"
}
