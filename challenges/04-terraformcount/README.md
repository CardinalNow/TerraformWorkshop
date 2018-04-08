# 04 - Terraform Count

## Expected Outcome

In this challenge, you will take what you did in Challenge 03 and expand to take a count variable.

## How to

### Copy Terraform Configuration

Copy the `main.tf` file you created in Challenge 03.

### Add a count variable

Create a new variable called `vmcount` and default it to `1`.

```hcl
variable "vmcount" {
  default = 2
}
```

### Update Existing Resources

Not every resource needs to scale as the number of VM's increase.

The Vnet and Subnet will not change, however we will have to scale the NIC, Public IP, and VM resources.

Each of these resources you will need make these changes:

- Add the count variable

```hcl
    count = "${var.vmcount}"
```

- Update the resource name to include the count index, for example the VM resource:

```hcl
    name = "challeng03-vm${count.index}"
```

- Update the computer name on the VM resource.

- Update id references, for example the VM resource:

```hcl
    network_interface_ids = ["${element(azurerm_network_interface.module.*.id, count.index)}"]
```

- Update the outputs to display an array of IPs:

```hcl
    value = "${azurerm_network_interface.module.*.private_ip_address}"
```

### Run a plan

Run `terraform plan` and you will notice that names have been set using the count index:

```sh
...
  + azurerm_virtual_machine.module[0]
      ...
      name:                                                               "challeng03-vm0"
      ...
      os_profile.3613624746.computer_name:                                "challeng03vm0"
      ...

  + azurerm_virtual_machine.module[1]
      ...
      name:                                                               "challeng03-vm1"
      ...
      os_profile.3464018155.computer_name:                                "challeng03vm1"
      ...
```

### Clean up

Run `terraform destroy` to remove everything we created.

## Advanced areas to explore

- Target apply a single VM using the `-target` parameter.
- Add tags to each resource.

## Resources

- [Resource Targeting](https://www.terraform.io/docs/commands/plan.html#resource-targeting)
