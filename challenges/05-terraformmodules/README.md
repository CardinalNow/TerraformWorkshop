# 05 - Terraform Modules

## Expected Outcome

In this challenge, you will create a module to contain a scalable virtual machine deployment, then create an environment where you will call the module.

## How to

### Create Folder Structure

In order to organize your code, create the following folder structure with `main.tf` files.

```sh
├── environments
│   └── dev
│       └── main.tf
└── modules
    └── linux_virtual_machine
        └── main.tf
```

### Create the Module

Inside the `linux_virtual_machine` module folder copy over the terraform configuration from challenge 04.

### Create Variables

Extract name, vm size, username and password into variables without defaults.

This will result in them being required.

```hcl
variable "name" {}
variable "vm_size" {}
variable "username" {}
variable "password" {}
```

> Extra credit: How many other variables can you extract?

### Create the Environment

Change your working directory to the `environments/dev` folder.

Update main.tf to declare your module, it should look similar to this:

```hcl
module "myawesomelinuxvm" {
    source = "../../modules/linux_virtual_machine"
}
```

> Notice the relative module sourcing.

### Terraform Init

Run `terraform init`.

```sh
Initializing modules...
- module.myawesomelinuxvm
  Getting source "../../modules/linux_virtual_machine"

Error: module "myawesomelinuxvm": missing required argument "name"
Error: module "myawesomelinuxvm": missing required argument "vm_size"
Error: module "myawesomelinuxvm": missing required argument "username"
Error: module "myawesomelinuxvm": missing required argument "password"
```

We have a problem! We didn't set required variables for our module.

Update the `main.tf` file:

```hcl
module "myawesomelinuxvm" {
  source   = "../../modules/linux_virtual_machine"
  name     = "mysuperapp"
  vm_size  = "Standard_A2_v2"
  username = "testadmin"
  password = "Password1234!"
}
```

Run `terraform init` again, this time there should not be any errors.

## Terraform Plan

Run `terraform plan` and you should see your linux VM built from your module.

```sh
  + module.myawesomelinuxvm.azurerm_resource_group.module
      id:                                 <computed>
      location:                           "centralus"
      name:                               "mysuperapp-rg"

...

Plan: 6 to add, 0 to change, 0 to destroy.
```

## Add Another Module

Add another `module` block descrbing another set of VM's.

```hcl
module "differentlinuxvm" {
  source   = "../../modules/linux_virtual_machine"
  name     = "differentapp"
  vm_size  = "Standard_A2_v2"
  username = "testadmin"
  password = "Password1234!"
}
```

## Scale a single module

Set the count of your first module to 2 and rerun a plan.

```hcl
...
    vmcount = 2
...
```

Run a plan and observer that your first module can scale independently of the second one.

## Terraform Plan

Since we added another module call, we must run `terraform init` again before running `terraform plan`.

We should see twice as much infrastructure in our plan.

```sh
  + module.myawesomelinuxvm.azurerm_resource_group.module
      id:                                 <computed>
      location:                           "centralus"
      name:                               "mysuperapp-rg"

...

  + module.differentlinuxvm.azurerm_resource_group.module
      id:                                 <computed>
      location:                           "centralus"
      name:                               "differentapp-rg"

...

Plan: 12 to add, 0 to change, 0 to destroy.

```

## More Variables

In your `environments/dev/main.tf` file we can see some duplication and secrets we do not want to store in configuration.

Add two variables to your environment `main.tf` file for username and password.

Create a new file and name it `terraform.tfvars` that will contain our secrets and automatically loaded when we run a `plan`.

```hcl
username = "testadmin"
password = "Password1234!"
```

## Terraform Plan

Run `terraform plan` and verify that your plan succeeds and looks the same.

## Advanced areas to explore

1. Use environment variables to load your secrets.

## Resources

- []()
- []()
- []()
