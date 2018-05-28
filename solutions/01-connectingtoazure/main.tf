provider "azurerm" {
  version = "= 1.4"
}

terraform {
  required_version = ">= 0.11.7"
}

// resource "azurerm_resource_group" "main" {
//   name     = "challenge01-rg"
//   location = "eastus"
// }

// resource "azurerm_resource_group" "count" {
//   name     = "challenge01-rg-${count.index}"
//   location = "eastus"
//   count    = 2
// }

resource "azurerm_resource_group" "main" {
  name     = "myportal-rg"
  location = "centralus"

  tags {
    terraform = "true"
  }
}

resource "azurerm_storage_account" "main" {
  name                     = "myusernamestorageaccount"
  resource_group_name      = "${azurerm_resource_group.main.name}"
  location                 = "centralus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags {
    terraform = "true"
  }
}
