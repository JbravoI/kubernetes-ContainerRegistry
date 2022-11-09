# resource "azurerm_private_dns_zone" "privatelink" {
#   name                = "privatelink.eastus.azmk8s.io"
#   resource_group_name = var.resource_group_name
# }

# resource "azurerm_user_assigned_identity" "userid" {
#   name                = "aks-userid-identity"
#   resource_group_name = var.resource_group_name
#   location            = var.location
# }

# resource "azurerm_role_assignment" "role" {
#   scope                = azurerm_private_dns_zone.privatelink.id
#   role_definition_name = "Private DNS Zone Contributor"
#   principal_id         = azurerm_user_assigned_identity.userid.principal_id
# }

resource "azurerm_kubernetes_cluster" "kube" {
  name                    = "${var.environmentname}-kube"
  location                = var.environmentlocation
  resource_group_name     = var.environmentname
  dns_prefix              = "${var.environmentname}-dns"
  kubernetes_version      = "1.22"
  public_network_access_enabled = "true"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

}

resource "azurerm_role_assignment" "roleassign" {
  principal_id                     = azurerm_kubernetes_cluster.kube.kubelet_identity[0].object_id
  role_definition_name             = "${var.environmentname}-AcrPull"
  scope                            = azurerm_container_registry.example.id
  skip_service_principal_aad_check = true
}