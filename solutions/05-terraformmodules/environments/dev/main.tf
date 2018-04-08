variable "username" {}
variable "password" {}

module "myawesomelinuxvm" {
  source   = "../../modules/linux_virtual_machine"
  name     = "mysuperapp"
  vm_size  = "Standard_A2_v2"
  username = "${var.username}"
  password = "${var.password}"
  vmcount  = 2
}

module "differentlinuxvm" {
  source   = "../../modules/linux_virtual_machine"
  name     = "differentapp"
  vm_size  = "Standard_A2_v2"
  username = "${var.username}"
  password = "${var.password}"
}
