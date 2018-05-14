# 01 - Connection To Azure

## Expected Outcome

In this challenge, you will connect Terraform on your local machine to your Azure Subscription.

In this challenge, you will:
- initialize Terraform
- run a `plan` on simple a simple resource
- run an `apply` to create Azure infrastructure
- run a `destroy` to remove Azure infrastructure

> Note: While most of these commands should be relatively universal, you might encounter some issues running them from a Windows cmd shell.  If this happens to you, try running the commands from the Git bash or PowerShell.

## How To

### Create Service Principal

Create a Service Principal on your Azure Subscription that Terraform will use to authenticate.
To do this we need to get the following:

- Tenant ID
- Subscription ID
- Client ID
- Client Secret

The tenant and subscription info are static, but we need to generate that service principal to get the Client ID and Secret.
To make things easy here is a one line command to get the job done:

```sh
az ad sp create-for-rbac -n TerraformAzureWorkshop --role="Contributor" --scopes /subscriptions/$(az account show -o tsv --query id)
```

> Note: As mentioned above, this command might not work in the cmd shell in Windows.  If you can't use PowerShell or the Git bash, you should be able to separate this into multiple commands to get around cmd shell limitations, first getting your account ID and using that in the second query, like so:
>
> `az account show -o tsv --query id`
>
> `az ad sp create-for-rbac -n TerraformAzureWorkshop --role="Contributor" --scopes /subscriptions/<ID from above query>`

You may see output stating "Retrying", this is normal and is just the CLI waiting for the role to be created.

When everything is complete you should see something like this:

```sh
Retrying role assignment creation: 1/36
Retrying role assignment creation: 2/36
Retrying role assignment creation: 3/36
Retrying role assignment creation: 4/36
{
  "appId": "THIS IS YOUR CLIENT ID",
  "displayName": "TerraformAzureWorkshop",
  "name": "http://TerraformAzureWorkshop",
  "password": "THIS IS YOUR CLIENT PASSWORD",
  "tenant": "THIS IS YOUR TENANT ID"
}
```

> The subscription id can be seen in the Azure Portal, or by running the Azure CLI command `az account show`

Take note of all 4 of these values and keep them safe, you will need to access them throughout the workshop.

> NOTE: It is a good idea to remove this Service Principal after the workshop!  Using the ID of the service principal, you can run an `az ad sp delete --id <ID>`.  See [here](https://docs.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest) for more details.

### Set Azure Credentials

There are several ways to authenticate Terraform for use with Azure.
For ease of this workshop, and to mimic the Terraform Enterprise work later, we will use the Environment Variables method.

Set the following environment variables based on the Service Principal:

```sh
export ARM_TENANT_ID=
export ARM_SUBSCRIPTION_ID=
export ARM_CLIENT_ID=
export ARM_CLIENT_SECRET=
```

Verify that the values are set `env | grep ".*ARM.*"`

```sh
$ env | grep ".*ARM.*"
ARM_SUBSCRIPTION_ID=<SUPER SECRET>
ARM_CLIENT_SECRET=<SUPER SECRET>
ARM_TENANT_ID=<SUPER SECRET>
ARM_CLIENT_ID=<SUPER SECRET>
```

### Create Terraform Configuration

Create a file named `main.tf` and add a single Resource Group resource.

```hcl
resource "azurerm_resource_group" "test" {
  name     = "challenge01-rg"
  location = "eastus"
}
```

This will create a simple Resource Group and allow you to walk through the Terraform Workflow.

### Run the Terraform Workflow

`terraform init`
<details><summary>View Output</summary>
<p>

```sh
$ terraform init

Initializing provider plugins...

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

---
`terraform plan`

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

  + azurerm_resource_group.main
      id:       <computed>
      location: "eastus"
      name:     "challenge01-rg"
      tags.%:   <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

</p>
</details>

---
`terraform apply`
<details><summary>View Output</summary>
<p>

```sh
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + azurerm_resource_group.main
      id:       <computed>
      location: "eastus"
      name:     "challenge01-rg"
      tags.%:   <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

azurerm_resource_group.main: Creating...
  location: "" => "eastus"
  name:     "" => "challenge01-rg"
  tags.%:   "" => "<computed>"
azurerm_resource_group.main: Creation complete after 1s (ID: /subscriptions/.../resourceGroups/challenge01-rg)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
</p>
</details>

---

Congrats, you just created your first Azure resource using Terraform!

### Verify in the Azure Portal

Head over to the [Azure Portal](https://portal.azure.com/)

View all Resource Groups and you should see the recently created Resource Group.
![](../../img/2018-05-09-10-20-28.png)

### Scale Resources

Now add a new Resource Group resource that scales with a `count` parameter.

```hcl
resource "azurerm_resource_group" "count" {
  name     = "challenge01-rg-${count.index}"
  location = "eastus"
  count    = 2
}
```

Run another `terraform plan` and `terraform apply`.

### Cleanup Resources

When you are done, destroy the infrastructure, we no longer need it.

```sh
$ terraform destroy
azurerm_resource_group.main: Refreshing state... (ID: /subscriptions/.../resourceGroups/challenge01-rg)
azurerm_resource_group.count[0]: Refreshing state... (ID: /subscriptions/.../resourceGroups/challenge01-rg-0)
azurerm_resource_group.count[1]: Refreshing state... (ID: /subscriptions/.../resourceGroups/challenge01-rg-1)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - azurerm_resource_group.count[0]

  - azurerm_resource_group.count[1]

  - azurerm_resource_group.main


Plan: 0 to add, 0 to change, 3 to destroy.

Do you really want to destroy?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

azurerm_resource_group.main: Destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg)
azurerm_resource_group.count[1]: Destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg-1)
azurerm_resource_group.count[0]: Destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg-0)
azurerm_resource_group.count.0: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg-0, 10s elapsed)
azurerm_resource_group.main: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg, 10s elapsed)
azurerm_resource_group.count.1: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg-1, 10s elapsed)
azurerm_resource_group.count.1: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg-1, 20s elapsed)
azurerm_resource_group.count.0: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg-0, 20s elapsed)
azurerm_resource_group.main: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg, 20s elapsed)
azurerm_resource_group.count.1: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg-1, 30s elapsed)
azurerm_resource_group.count.0: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg-0, 30s elapsed)
azurerm_resource_group.main: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg, 30s elapsed)
azurerm_resource_group.count.0: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg-0, 40s elapsed)
azurerm_resource_group.count.1: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg-1, 40s elapsed)
azurerm_resource_group.main: Still destroying... (ID: /subscriptions/.../resourceGroups/challenge01-rg, 40s elapsed)
azurerm_resource_group.main: Destruction complete after 47s
azurerm_resource_group.count[0]: Destruction complete after 47s
azurerm_resource_group.count[1]: Destruction complete after 47s

Destroy complete! Resources: 3 destroyed.
```

## Advanced areas to explore

1. Play around with adjusting the `count` and `name` parameters, then running `apply`.
1. Add tags to each resource.

## Resources

- [Terraform Count](https://www.terraform.io/docs/configuration/interpolation.html#count-information)
