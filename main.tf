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

# Module to deploy Container Registry
module "container-registry" {
  source              = "./modules/Container_registry"
  environmentname     = var.resource_group_name
  environmentlocation = var.location
    retention_policy = {
    days    = 10
    enabled = true
  }
  enable_content_trust = true
}

# Module for Role assignment
module "role_assignment" {
  source   = "./modules/Container_registry"
  principalid = azurerm_kubernetes_cluster.example.kubelet_identity[0].object_id
  # scope_id             = local.rg_id
  # principal_ids        = each.value
}

