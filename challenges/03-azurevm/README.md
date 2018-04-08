# 03 - Azure Virtual Machine

## Expected Outcome

In this challenge, you will create a single Virtual Machine and deploy it to Azure.
The VM will include all the networking required and additionally a Public IP to allow access.

## How to

### Create the Terraform Configuration

We will start with a few of the basic components needed.

Create a `main.tf` file with the following resources:

- [Azure Resource Group](https://www.terraform.io/docs/providers/azurerm/r/resource_group.html)
- [Azure Virtual Network](https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html)
- [Azure Subnet](https://www.terraform.io/docs/providers/azurerm/r/subnet.html)

Use the same `location` for all resources.

### Run Terraform Init

Run `terraform init`:

<details><summary>View Output</summary>
<p>

```sh
$ terraform init
Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "azurerm" (1.3.2)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.azurerm: version = "~> 1.3"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

</p>
</details>

### Run Terraform Plan

Run `terraform plan`

<details><summary>View Output</summary>
<p>

```sh
$ terraform plan
Terraform will perform the following actions:

  + azurerm_resource_group.module
      id:                   <computed>
      location:             "centralus"
      name:                 "challenge03-rg"
      tags.%:               <computed>

  + azurerm_subnet.module
      id:                   <computed>
      address_prefix:       "10.0.1.0/24"
      ip_configurations.#:  <computed>
      name:                 "challenge03-subnet"
      resource_group_name:  "challenge03-rg"
      virtual_network_name: "challenge03-vnet"

  + azurerm_virtual_network.module
      id:                   <computed>
      address_space.#:      "1"
      address_space.0:      "10.0.0.0/16"
      location:             "centralus"
      name:                 "challenge03-vnet"
      resource_group_name:  "challenge03-rg"
      subnet.#:             <computed>
      tags.%:               <computed>


Plan: 3 to add, 0 to change, 0 to destroy.
```

</p>
</details>

### Terraform Apply

Run `terraform apply` and type "yes" to confirm you want to apply.

<details><summary>View Output</summary>
<p>

```sh
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + azurerm_resource_group.module
      id:                   <computed>
      location:             "centralus"
      name:                 "challenge03-rg"
      tags.%:               <computed>

  + azurerm_subnet.module
      id:                   <computed>
      address_prefix:       "10.0.1.0/24"
      ip_configurations.#:  <computed>
      name:                 "challenge03-subnet"
      resource_group_name:  "challenge03-rg"
      virtual_network_name: "challenge03-vnet"

  + azurerm_virtual_network.module
      id:                   <computed>
      address_space.#:      "1"
      address_space.0:      "10.0.0.0/16"
      location:             "centralus"
      name:                 "challenge03-vnet"
      resource_group_name:  "challenge03-rg"
      subnet.#:             <computed>
      tags.%:               <computed>


Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.module: Creating...
  location: "" => "centralus"
  name:     "" => "challenge03-rg"
  tags.%:   "" => "<computed>"
azurerm_resource_group.module: Creation complete after 1s (ID: /subscriptions/27e9ff76-ce7b-4176-b2bb-...40e1c999/resourceGroups/challenge03-rg)
azurerm_virtual_network.module: Creating...
  address_space.#:     "" => "1"
  address_space.0:     "" => "10.0.0.0/16"
  location:            "" => "centralus"
  name:                "" => "challenge03-vnet"
  resource_group_name: "" => "challenge03-rg"
  subnet.#:            "" => "<computed>"
  tags.%:              "" => "<computed>"
azurerm_virtual_network.module: Still creating... (10s elapsed)
azurerm_virtual_network.module: Creation complete after 12s (ID: /subscriptions/27e9ff76-ce7b-4176-b2bb-...twork/virtualNetworks/challenge03-vnet)
azurerm_subnet.module: Creating...
  address_prefix:       "" => "10.0.1.0/24"
  ip_configurations.#:  "" => "<computed>"
  name:                 "" => "challenge03-subnet"
  resource_group_name:  "" => "challenge03-rg"
  virtual_network_name: "" => "challenge03-vnet"
azurerm_subnet.module: Still creating... (10s elapsed)
azurerm_subnet.module: Creation complete after 11s (ID: /subscriptions/27e9ff76-ce7b-4176-b2bb-...enge03-vnet/subnets/challenge03-subnet)

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

</p>
</details>





### Add more Terraform Configuration

Now that we have networking in place, we will add the Virtual Machine and it's NIC.

Add the following resources to the `main.tf` file:

- [Azure Network Interface](https://www.terraform.io/docs/providers/azurerm/r/network_interface.html)
- [Azure Virtual Machine](https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html)

For the operating system, use the CentOS Image:

```hcl
storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.3"
    version   = "latest"
}
```

For the VM Size use `Standard_A2_v2`.

For the OS Disk use Azure Managed Disks.

Specify an output that contains the private IP address that was dynamically created for the VM.

### Create the VM

Run `terraform plan`, you should see the two additions (1 NIC and 1 VM).

Run `terraform apply`, you should deploy the new VM.

### Add a Public IP

Add a [Public IP Address](https://www.terraform.io/docs/providers/azurerm/r/public_ip.html)

Be sure to update the Network Interface as well.

Run `terraform apply`.

```sh
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

private-ip = [
    10.0.1.4,
    10.0.1.5
]
public-ip = [
    52.165.217.244,
    13.89.221.245
]
```

### Clean up

Run `terraform destroy` to remove everything we created.

## Advanced areas to explore

1. Add a data disk
1. Search for Marketplace Images.
1. How would you reference a custom image?

## Resources

- []()
- []()
- []()
