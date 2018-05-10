variable "username" {}
variable "password" {}

module "myawesomewindowsvm" {
  source = "../../modules/my_virtual_machine"
  name   = "awesomeapp"
  vm_size  = "Standard_A2_v2"
  username = "${var.username}"
  password = "${var.password}"
  vmcount = 2
}

module "differentwindowsvm" {
  source = "../../modules/my_virtual_machine"
  name   = "differentapp"
  vm_size  = "Standard_A2_v2"
  username = "${var.username}"
  password = "${var.password}"
}
