# Variables
variable "name" {}
variable "vm_size" {}
variable "username" {}
variable "password" {}

variable "location" {
  default = "centralus"
}

variable "vmcount" {
  default = 1
}

# Basic Resources
resource "azurerm_resource_group" "module" {
  name     = "${var.name}-rg"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "module" {
  name                = "${var.name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.module.location}"
  resource_group_name = "${azurerm_resource_group.module.name}"
}

resource "azurerm_subnet" "module" {
  name                 = "${var.name}-subnet"
  resource_group_name  = "${azurerm_resource_group.module.name}"
  virtual_network_name = "${azurerm_virtual_network.module.name}"
  address_prefix       = "10.0.1.0/24"
}

# VM Resources
resource "azurerm_public_ip" "module" {
  name                         = "${var.name}-pubip${count.index}"
  location                     = "${azurerm_resource_group.module.location}"
  resource_group_name          = "${azurerm_resource_group.module.name}"
  public_ip_address_allocation = "static"
  count                        = "${var.vmcount}"
}

resource "azurerm_network_interface" "module" {
  name                = "${var.name}-nic${count.index}"
  location            = "${azurerm_resource_group.module.location}"
  resource_group_name = "${azurerm_resource_group.module.name}"
  count               = "${var.vmcount}"

  ip_configuration {
    name                          = "config1"
    subnet_id                     = "${azurerm_subnet.module.id}"
    public_ip_address_id          = "${element(azurerm_public_ip.module.*.id, count.index)}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "module" {
  name                  = "${var.name}-vm${count.index}"
  location              = "${azurerm_resource_group.module.location}"
  resource_group_name   = "${azurerm_resource_group.module.name}"
  network_interface_ids = ["${element(azurerm_network_interface.module.*.id, count.index)}"]
  vm_size               = "${var.vm_size}"
  count                 = "${var.vmcount}"

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.name}vm-osdisk${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.name}vm${count.index}"
    admin_username = "${var.username}"
    admin_password = "${var.password}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# Outputs
output "private-ip" {
  value       = "${azurerm_network_interface.module.*.private_ip_address}"
  description = "Private IPs"
}

output "public-ip" {
  value       = "${azurerm_public_ip.module.*.ip_address}"
  description = "Public IPs"
}
