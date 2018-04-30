# 01 - Connection To Azure

## Expected Outcome

In this challenge, you will connect Terraform on your local machine to your Azure Subscription.

In this challenge, you will:
- initialize Terraform
- run a `plan` on simple a simple resource
- run an `apply` to create Azure infrastrcuture
- run a `destroy` to remove Azure infrastructure

## How to

### Verify Azure and Terraform

```sh
terraform -v
az -v
```

### Login to Azure CLI

`az login`

```sh
$ az login
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code FANCAHJ4R to authenticate.

```

### Verify Connection

`az account show -o table`

```sh
$ az account show -o table
EnvironmentName    IsDefault    Name                             State    TenantId
-----------------  -----------  -------------------------------  -------  ------------------------------------
AzureCloud         True         Visual Studio Premium with MSDN  Enabled  xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

### Create Terraform Configuration

Create a file named `main.tf` and add the following:

```hcl
resource "azurerm_resource_group" "test" {
  name     = "challenge01-rg"
  location = "centralus"
}
```

### Run the Terraform Workflow

`terraform init`

`terraform plan`

`terraform apply`

### Login to the Azure Portal

[Azure Portal](https://portal.azure.com/)

View all Resource Groups and you should see the recently created Resource Group.

### Cleanup Resources

`terraform destroy`

## Advanced areas to explore

1. Create Serivce Principal and login to Azure CLI with those credentials.
https://www.terraform.io/docs/providers/azurerm/authenticating_via_service_principal.html
1. Here

## Resources

- []()
- []()
- []()