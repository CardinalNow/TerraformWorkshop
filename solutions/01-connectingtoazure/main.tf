provider "azurerm" {
  version = "= 1.4"
}

terraform {
  required_version = "= 0.11.7"
}

resource "azurerm_resource_group" "main" {
  name     = "challenge01-rg"
  location = "eastus"
}

resource "azurerm_resource_group" "count" {
  name     = "challenge01-rg-${count.index}"
  location = "eastus"
  count    = 2
}
