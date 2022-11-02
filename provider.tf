terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.6.0"
    }
  }
}

provider "azurerm" {
  features {}
  #   // $username = "$(ARM_CLIENT_ID)"
  #   // $password = "$(ARM_CLIENT_SECRET)"
  #   // $tenantId = "$(ARM_TENANT_ID)"
}