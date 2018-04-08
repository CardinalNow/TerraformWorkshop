# Variables
variable "location" {
  default = "centralus"
}

# Basic Resources
resource "azurerm_resource_group" "module" {
  name     = "challenge03-rg"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "module" {
  name                = "challenge03-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.module.location}"
  resource_group_name = "${azurerm_resource_group.module.name}"
}

resource "azurerm_subnet" "module" {
  name                 = "challenge03-subnet"
  resource_group_name  = "${azurerm_resource_group.module.name}"
  virtual_network_name = "${azurerm_virtual_network.module.name}"
  address_prefix       = "10.0.1.0/24"
}

# VM Resources
resource "azurerm_public_ip" "module" {
  name                         = "challenge03-pubip"
  location                     = "${azurerm_resource_group.module.location}"
  resource_group_name          = "${azurerm_resource_group.module.name}"
  public_ip_address_allocation = "static"
}

resource "azurerm_network_interface" "module" {
  name                = "challenge03-nic"
  location            = "${azurerm_resource_group.module.location}"
  resource_group_name = "${azurerm_resource_group.module.name}"

  ip_configuration {
    name                          = "config1"
    subnet_id                     = "${azurerm_subnet.module.id}"
    public_ip_address_id          = "${azurerm_public_ip.module.id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "module" {
  name                  = "challenge03-vm"
  location              = "${azurerm_resource_group.module.location}"
  resource_group_name   = "${azurerm_resource_group.module.name}"
  network_interface_ids = ["${azurerm_network_interface.module.id}"]
  vm_size               = "Standard_A2_v2"

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"
  }

  storage_os_disk {
    name              = "challenge03vm-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "challenge03vm"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

## Outputs
output "private-ip" {
  value       = "${azurerm_network_interface.module.private_ip_address}"
  description = "Private IPs"
}

output "public-ip" {
  value       = "${azurerm_public_ip.module.ip_address}"
  description = "Public IPs"
}
