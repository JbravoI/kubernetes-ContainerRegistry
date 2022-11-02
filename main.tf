# Resource Group
resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resource_group_name
  location = var.location
}

# Module to create Vnet
module "vnet" {
  source              = "./modules/networking"
  environmentlocation = var.location
  environmentname     = var.resource_group_name
  resourcename        = var.resource_group_name
  depends_on          = [azurerm_resource_group.resourcegroup]
}

# Module to deploy AKS
module "aks" {
  source              = "./modules/kubernetes"
  environmentname     = var.resource_group_name
  environmentlocation = var.location
  #   client_id                        = "your-service-principal-client-appid"
  #   client_secret                    = "your-service-principal-client-password"
#   prefix = "${var.resource_group_name}-prefix"

  depends_on = [module.vnet]
}