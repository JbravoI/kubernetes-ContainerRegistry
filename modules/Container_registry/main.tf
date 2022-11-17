resource "azurerm_container_registry" "Containerreg" {
  name                = "${var.environmentname}containertest"
  resource_group_name = var.environmentname
  location            = var.environmentlocation
  sku                 = "Premium"
  #admin_enabled       = true
}
