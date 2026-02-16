resource "azurerm_resource_group" "core" {
  name     = "cloudops-${var.env}-core-rg"
  location = var.location

  tags = {
    project = var.project
    env     = var.env
  }
}