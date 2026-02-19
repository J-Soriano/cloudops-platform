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

resource "azurerm_log_analytics_workspace" "core_law" {
  name                = "cloudops-${var.env}-law"
  location            = var.location
  resource_group_name = azurerm_resource_group.core.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_analytics_retention_days

  tags = {
    project = var.project
    env     = var.env
  }
}

resource "azurerm_monitor_diagnostic_setting" "app_nsg_diag" {
  name                       = "cloudops-${var.env}-app-nsg-diag"
  target_resource_id         = azurerm_network_security_group.app_nsg.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.core_law.id

  enabled_log {
    category = "NetworkSecurityGroupEvent"
  }

  enabled_log {
    category = "NetworkSecurityGroupRuleCounter"
  }
}
