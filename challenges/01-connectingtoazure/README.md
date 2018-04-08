# 01 - Connection To Azure

## Expected Outcome

In this challenge, you will connect Terraform on your local machine to your Azure Subscription.

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



## Advanced areas to explore

1. Create Serivce Principal and login to Azure CLI with those credentials.
https://www.terraform.io/docs/providers/azurerm/authenticating_via_service_principal.html
1. Here

## Resources

- []()
- []()
- []()