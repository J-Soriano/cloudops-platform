output "resource_group_name" {
  value = azurerm_resource_group.core.name
}

output "vnet_name" {
  value = azurerm_virtual_network.core_vnet.name
}

output "app_subnet_id" {
  value = azurerm_subnet.app_subnet.id
}

output "app_nsg_name" {
  value = azurerm_network_security_group.app_nsg.name
}

output "app_nsg_id" {
  value = azurerm_network_security_group.app_nsg.id
}