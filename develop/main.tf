terraform {
  required_version = "= 0.11.6"
}

provider "azurerm" {
  version = "1.3.0"
}

resource "azurerm_resource_group" "module" {
  name     = "${var.name}-rg"
  location = "${var.location}"
}

variable "name" {}

variable "location" {
  default = "centralus"
}


output "rg-name" {
  value = "${azurerm_resource_group.module.name}"
}


// variable "subnet_id" {}
// variable "username" {}
// variable "password" {}


// module "linux_vm" {
//   source  = "app.terraform.io/cardinalsolutions/modules/azurerm"
//   version = "0.0.1"
//   location  = "${var.location}"
//   resource_group_name = "${azurerm_resource_group.module.name}"
//   name      = "${var.name}"
//   os = "OpenLogic:CentOS:7.3:latest"
//   subnet_id = "${var.subnet_id}"
//   username = "${var.username}"
//   password = "${var.password}"
// }

