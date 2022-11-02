#Creating VNET
resource "azurerm_virtual_network" "vnet" {
  depends_on=[var.resourcename]
  name                = "${var.environmentname}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.environmentlocation
  resource_group_name = var.environmentname
}

# Creasting of Subnet 1 & 2
resource "azurerm_subnet" "subnet1" {
  depends_on=[var.resourcename]
  name                 = "${var.environmentname}-subnet1"
  resource_group_name  = var.environmentname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  depends_on=[var.resourcename]
  name                 = "${var.environmentname}-subnet2"
  resource_group_name  = var.environmentname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Creating of Network interface for VM 1
resource "azurerm_network_interface" "networkinterface1" {
  depends_on=[var.resourcename]
  name                = "${var.environmentname}-nic-1"
  location            = var.environmentlocation
  resource_group_name = var.environmentname

  ip_configuration {
    name                          = "${var.environmentname}-ipconfig"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vmpublicip1.id
  }
}

# Creating of Network interface for VM 2
resource "azurerm_network_interface" "networkinterface2" {
  depends_on=[var.resourcename]
  name                = "${var.environmentname}-nic-2"
  location            = var.environmentlocation
  resource_group_name = var.environmentname

  ip_configuration {
    name                          = "${var.environmentname}-ipconfig"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vmpublicip2.id
  }
}

# Creating Static Public IP for VM1
resource "azurerm_public_ip" "vmpublicip1" {
  depends_on=[var.resourcename]
  name                = "${var.environmentname}-vm-ip-1"
  location            = var.environmentlocation
  resource_group_name = var.environmentname
  allocation_method   = "Static"
}


# Creating Static Public IP
resource "azurerm_public_ip" "vmpublicip2" {
  depends_on=[var.resourcename]
  name                = "${var.environmentname}-vm-ip-2"
  location            = var.environmentlocation
  resource_group_name = var.environmentname
  allocation_method   = "Static"
}