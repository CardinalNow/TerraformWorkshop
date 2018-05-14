// provider "azurerm" {
//   version = "= 1.4"
// }

terraform {
  required_version = "= 0.11.7"
}

module "network" {
  source              = "Azure/network/azurerm"
  version             = "2.0.0"
  resource_group_name = "myapp-networking"
  location            = "eastus"

  tags = {
    environment = "dev"
  }
}

module "windowsservers" {
  source              = "Azure/compute/azurerm"
  version             = "1.1.5"
  resource_group_name = "myapp-compute-windows"
  location            = "eastus"
  admin_password      = "ComplxP@ssw0rd!"
  vm_os_simple        = "WindowsServer"
  nb_public_ip        = 0
  vnet_subnet_id      = "${module.network.vnet_subnets[0]}"
}

module "linuxservers" {
  source              = "Azure/compute/azurerm"
  version             = "1.1.5"
  resource_group_name = "myapp-compute-linux"
  location            = "eastus"
  vm_os_simple        = "UbuntuServer"
  nb_public_ip        = 0
  vnet_subnet_id      = "${module.network.vnet_subnets[0]}"
}
