resource "azurerm_resource_group" "core" {
  name     = "cloudops-${var.env}-core-rg"
  location = var.location

  tags = {
    project = var.project
    env     = var.env
  }
}
resource "azurerm_virtual_network" "core_vnet" {
  name                = "cloudops-${var.env}-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.core.name
  address_space       = ["10.10.0.0/16"]

  tags = {
    project = var.project
    env     = var.env
  }
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "app"
  resource_group_name  = azurerm_resource_group.core.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = "cloudops-${var.env}-app-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.core.name

  tags = {
    project = var.project
    env     = var.env
  }
}

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_assoc" {
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}