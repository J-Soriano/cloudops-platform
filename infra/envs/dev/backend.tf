terraform {
  backend "azurerm" {
    resource_group_name  = "cloudops-tfstate-rg"
    storage_account_name = "cloudopstfstate01" # <-- replace with YOUR storage account name
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}