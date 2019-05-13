# 00 - Getting Started

## Expected Outcome

In this challenge, you will connect to the [Azure Cloud Shell](https://azure.microsoft.com/en-us/features/cloud-shell/) that will be needed for future challenges.

In this challenge, you will:

- Login to the Azure Portal
- Verify `az` installation
- Verify `terraform` installation
- Create a folder structure to complete challenges

> Note: If you would rather complete the challenges from you local worskstation, detailed instructions can be found [here](local.md).
## How to

### Login to the Azure Portal

Navigate to [https://portal.azure.com](https://portal.azure.com) and login with your Azure Credentials.

This workshop will require that you have access to an Azure Subscription with at least Contributor rights to create resources. If you do not currently have access you can create a trial account by going to [https://azure.microsoft.com/en-us/free](https://azure.microsoft.com/en-us/free) and registering for a 3-month trail.

Signing up for a trial requires:

- A unique Microsoft Live Account that has not registered for a trial for in the past
- A Credit Card, used to verify identity and will not be charged unless you opt-in after the trial is over

> If you are having issues with this access, please alert the instructor ASAP as this will prevent you from completing the challenges.

### Open the Cloud Shell

Located at the top of the page is the button open the Azure Cloud Shell inside the Azure Portal.

![](../../img/2018-05-28-12-25-01.png)

> Note: Another option is to use the full screen Azure Cloud Shell at [https://shell.azure.com/](https://shell.azure.com/).

The first time you connect to the Azure Cloud Shell you will be prompted to setup an Azure File Share that you will persist the environment.

![](../../img/2018-05-28-12-27-31.png)

Click the "Bash (Linux)" option.

Select the Azure Subscription and click "Create storage":

![](../../img/2018-05-28-12-29-06.png)

After a few seconds you should see that your storage account has been created:

![](../../img/2018-05-28-12-30-33.png)

> Note: Behind the scenes this is creating a new Resource Group with the name `cloud-shell-storage-eastus` (or which ever region you defaulted to). If you need more information, it can be found [here](https://docs.microsoft.com/en-us/azure/cloud-shell/persisting-shell-storage).

SUCCESS!
You are now logged into the Azure Cloud Shell which uses your portal session to automatically authenticate you with the Azure CLI and Terraform.

### Verify Utilities

In the Cloud Shell type the following commands and verify that the utilities are installed:

`az -v`

<details><summary>View Output</summary>
<p>

```sh
$ az -v
azure-cli (2.0.64)

acr                                2.2.6
acs                                2.4.1
advisor                            2.0.0
ams                                0.4.5
appservice                        0.2.19
backup                             1.2.4
batch                              4.0.1
batchai                            0.4.8
billing                            0.2.1
botservice                         0.2.0
cdn                                0.2.3
cloud                              2.1.1
cognitiveservices                  0.2.5
command-modules-nspkg               2.0.2
configure                         2.0.23
consumption                        0.4.2
container                         0.3.16
core                              2.0.64
cosmosdb                          0.2.10
deploymentmanager                  0.1.0
dla                                0.2.5
dls                                0.1.9
dms                                0.1.3
eventgrid                          0.2.3
eventhubs                          0.3.5
extension                          0.2.5
feedback                           2.2.1
find                               0.3.2
hdinsight                          0.3.3
interactive                        0.4.3
iot                                0.3.8
iotcentral                         0.1.6
keyvault                          2.2.15
kusto                              0.2.2
lab                                0.1.7
maps                               0.3.4
monitor                           0.2.13
network                            2.4.0
nspkg                              3.0.3
policyinsights                     0.1.3
privatedns                         1.0.0
profile                            2.1.5
rdbms                             0.3.10
redis                              0.4.2
relay                              0.1.4
reservations                       0.4.2
resource                          2.1.14
role                               2.6.1
search                             0.1.1
security                           0.1.1
servicebus                         0.3.5
servicefabric                     0.1.18
signalr                            1.0.0
sql                                2.2.3
sqlvm                              0.1.1
storage                            2.4.1
telemetry                          1.0.2
vm                                2.2.20

Python location '/opt/az/bin/python3'
Extensions directory '~/.azure/cliextensions'

Python (Linux) 3.6.5 (default, May  2 2019, 00:44:44)
[GCC 5.4.0 20160609]

Legal docs and information: aka.ms/AzureCliLegal

Your CLI is up-to-date.
```
</p>
</details>

`terraform -v`

<details><summary>View Output</summary>
<p>

```sh
$ terraform -v
Terraform v0.11.13
```

</p>
</details>

### Verify Subscription

Run the command `az account list -o table`.

```sh
az account list -o table
Name                             CloudName    SubscriptionId                        State    IsDefault
-------------------------------  -----------  ------------------------------------  -------  -----------
Visual Studio Premium with MSDN  AzureCloud   xxxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx  Enabled  True
Another sub1                     AzureCloud   xxxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx  Enabled  False
Another sub2                     AzureCloud   xxxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx  Enabled  False
Another sub3                     AzureCloud   xxxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxx  Enabled  False
```

If you have more than subscription, make sure that subscription is set as default using the subscription name:

```sh
az account set -s 'Visual Studio Premium with MSDN'
```

### Create Challenge Scaffolding

To make things easy for the challenges, let's create a folder structure to hold the terraform configuration we will create.

Make sure you are in the home directory:

```sh
cd ~/
```

Run the following in the azure cloud shell, this will simply create a folder structure for you to place your Terraform configuration:

```sh
mkdir AzureWorkChallenges && cd AzureWorkChallenges && mkdir challenge01 && mkdir challenge02 && mkdir challenge03 && mkdir challenge04 && mkdir challenge05 && mkdir challenge06 && mkdir challenge07
```

What you should end up with is a structure like this:

```sh
AzureWorkChallenges
|- challenge01
|- challenge02
|- challenge03
|- challenge04
|- challenge05
|- challenge06
|- challenge07
```
