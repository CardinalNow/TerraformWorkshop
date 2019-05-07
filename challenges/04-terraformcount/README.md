# 04 - Terraform Count

## Expected Outcome

In this challenge, you will take what you did in Challenge 03 and expand to take a count variable.

Be aware that if you did not destroy the infrastructure from Challenge 03 you may run into resource naming conflicts (namely "Resource already exists").

## How to

### Copy Terraform Configuration

From the Cloud Shell, change directory into a folder specific to this challenge. If you created the scaffolding in Challenge 00, then then you can use the command `cd ~/AzureWorkChallenges/challenge04/`.

Copy the `main.tf` file from challenge 03 into the current directory.

Be sure to update the value of the `name` variable:

```hcl
variable "name" {
  default = "challenge04"
}
```

### Add a count variable

Create a new variable called `vmcount` and default it to `1`.

```hcl
variable "vmcount" {
  default = 1
}
```

### Update Existing Resources

Not every resource needs to scale as the number of VM's increase.

The Resource Group, Virtual Network and Subnet will not change.

We will have to scale the Network Interface, Public IP, and VM resources.

Each of these resources you will need make these changes:

- Add the count variable

```hcl
    count = "${var.vmcount}"
```

- Update the resource name to include the count index, for example the VM resource:

```hcl
    name = "${var.name}-vm${count.index}"
```

- Update the OS Disk Name on the VM resource:

```hcl
    storage_os_disk {
        name = "${var.name}vm${count.index}-osdisk"
        ...
    }
```

- Update the computer name on the VM resource.

```hcl
    os_profile {
        computer_name = "${var.name}vm${count.index}"
        ...
    }
```

- Update the ID reference for the Virtual Machine:

```hcl
    network_interface_ids = ["${element(azurerm_network_interface.main.*.id, count.index)}"]
```

- Update the Public IP block:

```hcl
resource "azurerm_public_ip" "main" {
    name                         = "${var.name}-pubip${count.index}"
    ...
    count                        = "${var.vmcount}"
}
```

- Update the Public IP ID reference for the Network Interface:

```hcl
    public_ip_address_id = "${element(azurerm_public_ip.main.*.id, count.index)}"
```

- Update the Private IP outputs to display an array of IPs:

```hcl
    value = "${azurerm_network_interface.main.*.private_ip_address}"
```

- Update the Public IP outputs to display an array of IPs:

```hcl
    value = "${azurerm_public_ip.main.*.ip_address}"
```

### Run a plan

If all the changes above have been made without error, runnning `terraform init` and `terraform plan` should execute without any errors.

The plan should end with:

```sh
Plan: 6 to add, 0 to change, 0 to destroy.
```

Now investigate this plan in more detail and you will notice that names have been set using the count index:

```sh
...
  + azurerm_virtual_machine.module[0]
      ...
      name:                                 "challenge04-vm0"
      ...
      os_profile.3613624746.computer_name:  "challenge04vm0"
      ...

```

### Update Count

Set the default value of the count to `2`.
Before running a plan consider the following questions:

- How many resources do expect the plan to show?
- What will the outputs look like?

Your plan should look similar to the following
<details><summary>View Output</summary>
<p>

```sh
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + azurerm_network_interface.main[0]
      id:                                                                 <computed>
      applied_dns_servers.#:                                              <computed>
      dns_servers.#:                                                      <computed>
      enable_accelerated_networking:                                      "false"
      enable_ip_forwarding:                                               "false"
      internal_dns_name_label:                                            <computed>
      internal_fqdn:                                                      <computed>
      ip_configuration.#:                                                 "1"
      ip_configuration.0.application_gateway_backend_address_pools_ids.#: <computed>
      ip_configuration.0.application_security_group_ids.#:                <computed>
      ip_configuration.0.load_balancer_backend_address_pools_ids.#:       <computed>
      ip_configuration.0.load_balancer_inbound_nat_rules_ids.#:           <computed>
      ip_configuration.0.name:                                            "config1"
      ip_configuration.0.primary:                                         <computed>
      ip_configuration.0.private_ip_address:                              <computed>
      ip_configuration.0.private_ip_address_allocation:                   "dynamic"
      ip_configuration.0.public_ip_address_id:                            "${element(azurerm_public_ip.main.*.id, count.index)}"
      ip_configuration.0.subnet_id:                                       "${azurerm_subnet.main.id}"
      location:                                                           "eastus"
      mac_address:                                                        <computed>
      name:                                                               "challenge04-nic0"
      private_ip_address:                                                 <computed>
      private_ip_addresses.#:                                             <computed>
      resource_group_name:                                                "challenge04-rg"
      tags.%:                                                             <computed>
      virtual_machine_id:                                                 <computed>

  + azurerm_network_interface.main[1]
      id:                                                                 <computed>
      applied_dns_servers.#:                                              <computed>
      dns_servers.#:                                                      <computed>
      enable_accelerated_networking:                                      "false"
      enable_ip_forwarding:                                               "false"
      internal_dns_name_label:                                            <computed>
      internal_fqdn:                                                      <computed>
      ip_configuration.#:                                                 "1"
      ip_configuration.0.application_gateway_backend_address_pools_ids.#: <computed>
      ip_configuration.0.application_security_group_ids.#:                <computed>
      ip_configuration.0.load_balancer_backend_address_pools_ids.#:       <computed>
      ip_configuration.0.load_balancer_inbound_nat_rules_ids.#:           <computed>
      ip_configuration.0.name:                                            "config1"
      ip_configuration.0.primary:                                         <computed>
      ip_configuration.0.private_ip_address:                              <computed>
      ip_configuration.0.private_ip_address_allocation:                   "dynamic"
      ip_configuration.0.public_ip_address_id:                            "${element(azurerm_public_ip.main.*.id, count.index)}"
      ip_configuration.0.subnet_id:                                       "${azurerm_subnet.main.id}"
      location:                                                           "eastus"
      mac_address:                                                        <computed>
      name:                                                               "challenge04-nic1"
      private_ip_address:                                                 <computed>
      private_ip_addresses.#:                                             <computed>
      resource_group_name:                                                "challenge04-rg"
      tags.%:                                                             <computed>
      virtual_machine_id:                                                 <computed>

  + azurerm_public_ip.main[0]
      id:                                                                 <computed>
      fqdn:                                                               <computed>
      ip_address:                                                         <computed>
      location:                                                           "eastus"
      name:                                                               "challenge04-pubip0"
      public_ip_address_allocation:                                       "static"
      resource_group_name:                                                "challenge04-rg"
      sku:                                                                "Basic"
      tags.%:                                                             <computed>

  + azurerm_public_ip.main[1]
      id:                                                                 <computed>
      fqdn:                                                               <computed>
      ip_address:                                                         <computed>
      location:                                                           "eastus"
      name:                                                               "challenge04-pubip1"
      public_ip_address_allocation:                                       "static"
      resource_group_name:                                                "challenge04-rg"
      sku:                                                                "Basic"
      tags.%:                                                             <computed>

  + azurerm_resource_group.main
      id:                                                                 <computed>
      location:                                                           "eastus"
      name:                                                               "challenge04-rg"
      tags.%:                                                             <computed>

  + azurerm_subnet.main
      id:                                                                 <computed>
      address_prefix:                                                     "10.0.1.0/24"
      ip_configurations.#:                                                <computed>
      name:                                                               "challenge04-subnet"
      resource_group_name:                                                "challenge04-rg"
      virtual_network_name:                                               "challenge04-vnet"

  + azurerm_virtual_machine.main[0]
      id:                                                                 <computed>
      availability_set_id:                                                <computed>
      delete_data_disks_on_termination:                                   "false"
      delete_os_disk_on_termination:                                      "false"
      identity.#:                                                         <computed>
      location:                                                           "eastus"
      name:                                                               "challenge04-vm0"
      network_interface_ids.#:                                            <computed>
      os_profile.#:                                                       "1"
      os_profile.1750279281.admin_password:                               <sensitive>
      os_profile.1750279281.admin_username:                               "testadmin"
      os_profile.1750279281.computer_name:                                "challenge04vm0"
      os_profile.1750279281.custom_data:                                  <computed>
      os_profile_windows_config.#:                                        "1"
      os_profile_windows_config.429474957.additional_unattend_config.#:   "0"
      os_profile_windows_config.429474957.enable_automatic_upgrades:      "false"
      os_profile_windows_config.429474957.provision_vm_agent:             "false"
      os_profile_windows_config.429474957.winrm.#:                        "0"
      resource_group_name:                                                "challenge04-rg"
      storage_image_reference.#:                                          "1"
      storage_image_reference.3904372903.id:                              ""
      storage_image_reference.3904372903.offer:                           "WindowsServer"
      storage_image_reference.3904372903.publisher:                       "MicrosoftWindowsServer"
      storage_image_reference.3904372903.sku:                             "2016-Datacenter"
      storage_image_reference.3904372903.version:                         "latest"
      storage_os_disk.#:                                                  "1"
      storage_os_disk.0.caching:                                          "ReadWrite"
      storage_os_disk.0.create_option:                                    "FromImage"
      storage_os_disk.0.disk_size_gb:                                     <computed>
      storage_os_disk.0.managed_disk_id:                                  <computed>
      storage_os_disk.0.managed_disk_type:                                "Standard_LRS"
      storage_os_disk.0.name:                                             "challenge04vm0-osdisk"
      tags.%:                                                             <computed>
      vm_size:                                                            "Standard_A2_v2"

  + azurerm_virtual_machine.main[1]
      id:                                                                 <computed>
      availability_set_id:                                                <computed>
      delete_data_disks_on_termination:                                   "false"
      delete_os_disk_on_termination:                                      "false"
      identity.#:                                                         <computed>
      location:                                                           "eastus"
      name:                                                               "challenge04-vm1"
      network_interface_ids.#:                                            <computed>
      os_profile.#:                                                       "1"
      os_profile.1900549424.admin_password:                               <sensitive>
      os_profile.1900549424.admin_username:                               "testadmin"
      os_profile.1900549424.computer_name:                                "challenge04vm1"
      os_profile.1900549424.custom_data:                                  <computed>
      os_profile_windows_config.#:                                        "1"
      os_profile_windows_config.429474957.additional_unattend_config.#:   "0"
      os_profile_windows_config.429474957.enable_automatic_upgrades:      "false"
      os_profile_windows_config.429474957.provision_vm_agent:             "false"
      os_profile_windows_config.429474957.winrm.#:                        "0"
      resource_group_name:                                                "challenge04-rg"
      storage_image_reference.#:                                          "1"
      storage_image_reference.3904372903.id:                              ""
      storage_image_reference.3904372903.offer:                           "WindowsServer"
      storage_image_reference.3904372903.publisher:                       "MicrosoftWindowsServer"
      storage_image_reference.3904372903.sku:                             "2016-Datacenter"
      storage_image_reference.3904372903.version:                         "latest"
      storage_os_disk.#:                                                  "1"
      storage_os_disk.0.caching:                                          "ReadWrite"
      storage_os_disk.0.create_option:                                    "FromImage"
      storage_os_disk.0.disk_size_gb:                                     <computed>
      storage_os_disk.0.managed_disk_id:                                  <computed>
      storage_os_disk.0.managed_disk_type:                                "Standard_LRS"
      storage_os_disk.0.name:                                             "challenge04vm1-osdisk"
      tags.%:                                                             <computed>
      vm_size:                                                            "Standard_A2_v2"

  + azurerm_virtual_network.main
      id:                                                                 <computed>
      address_space.#:                                                    "1"
      address_space.0:                                                    "10.0.0.0/16"
      location:                                                           "eastus"
      name:                                                               "challenge04-vnet"
      resource_group_name:                                                "challenge04-rg"
      subnet.#:                                                           <computed>
      tags.%:                                                             <computed>


Plan: 9 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

</p>
</details>

Run `terraform apply` to create all the infrastructure.

### Azure Portal

In the Azure Portal, view all the resources in the `challenge04-rg` Resource Group.

How important do think naming is?

How can Terraform help with keeping things consistent?

### Clean up

Run `terraform destroy` to remove everything we created.

## Advanced areas to explore

1. Add an Azure Load Balancer.
2. Add tags to the Virtual Machine and then use the `-target` option to target only a single resource.

## Resources

- [Azure Load Balancer](https://www.terraform.io/docs/providers/azurerm/r/loadbalancer.html)
- [Resource Targeting](https://www.terraform.io/docs/commands/plan.html#resource-targeting)
