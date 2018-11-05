resource "azurerm_resource_group" "main" {
  name     = "challenge01-rg"
  location = "eastus"
}

resource "azurerm_resource_group" "count" {
  name     = "challenge01-rg-${count.index}"
  location = "eastus"
  count    = 2
}

// Import these resources that were manually created in the Azure Portal
resource "azurerm_resource_group" "import" {
  name     = "myportal-rg"
  location = "eastus"
  
  tags {
    terraform = "true"
  }
}

resource "azurerm_storage_account" "import" {
  name                      = "myusernamestorageaccount"
  resource_group_name       = "${azurerm_resource_group.import.name}"
  location                  = "eastus"
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  
  tags {
    terraform = "true"
  }
}
