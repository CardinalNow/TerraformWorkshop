resource "random_pet" "main" {
  length    = 2
  separator = ""
}

resource "azurerm_resource_group" "main" {
  name     = "aci-helloworld"
  location = "eastus"
}

resource "azurerm_storage_account" "main" {
  name                     = "acidev${random_pet.main.id}"
  resource_group_name      = "${azurerm_resource_group.main.name}"
  location                 = "${azurerm_resource_group.main.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "main" {
  name                 = "aci-test-share"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  storage_account_name = "${azurerm_storage_account.main.name}"
  quota                = 1
}

resource "azurerm_container_group" "main" {
  name                = "aci-helloworld"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  ip_address_type     = "public"
  dns_name_label      = "aci-${random_pet.main.id}"
  os_type             = "linux"

  container {
    name   = "helloworld"
    image  = "microsoft/aci-helloworld"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }

    environment_variables {
      "NODE_ENV" = "testing"
    }

    volume {
      name       = "logs"
      mount_path = "/aci/logs"
      read_only  = false
      share_name = "${azurerm_storage_share.main.name}"

      storage_account_name = "${azurerm_storage_account.main.name}"
      storage_account_key  = "${azurerm_storage_account.main.primary_access_key}"
    }
  }

  container {
    name   = "sidecar"
    image  = "microsoft/aci-tutorial-sidecar"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags {
    environment = "testing"
  }
}

resource "azurerm_container_group" "windows" {
  name                = "aci-iis"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  ip_address_type     = "public"
  dns_name_label      = "aci-iis-${random_pet.main.id}"
  os_type             = "windows"

  container {
    name   = "dotnetsample"
    image  = "microsoft/iis"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags {
    environment = "testing"
  }
}
