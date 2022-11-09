resource "azurerm_container_registry" "Containerreg" {
  name                = "${var.environmentname}-CR"
  resource_group_name = var.environmentname
  location            = var.environmentlocation
  sku                 = "Premium"
  #admin_enabled       = true
}

resource "azurerm_role_assignment" "example" {
  principal_id                     = var.principalid
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.Containerreg.id
  skip_service_principal_aad_check = true
}