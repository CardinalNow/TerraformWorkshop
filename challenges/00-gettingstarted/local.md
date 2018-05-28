# Installing Challenge Requirements Locally

This section is only needed if you wish to install all the tooling on your local machine.

> NOTE: If you are using windows, it is advised that you use the git-bash terminal to execute the workshop commands.

## How to

### Download the Azure CLI 2.0

To make some of the steps easier we will use the Azure CLI and authenticate to Azure.

Download and install the latest Azure CLI:

For **Windows** - [Download Here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest)

For **Mac** - [Download Here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-macos?view=azure-cli-latest)

> If you are having issues, more information can be found [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

Verify the installation by running `az -v`, you should see something like this, version 2.0.0 or higher is needed:

```sh
$ az -v
azure-cli (2.0.32)

... Other python dependencies

Python (Darwin) 3.6.5 (default, Apr 25 2018, 14:26:36)
[GCC 4.2.1 Compatible Apple LLVM 9.0.0 (clang-900.0.39.2)]

Legal docs and information: aka.ms/AzureCliLegal
```

### Login to Azure

This workshop will require that you have access to an Azure Subscription with at least Contributor rights to create resources and the ability to generate a service principal for the subscription. If you do not currently have access you can create a trial account by going to [https://azure.microsoft.com/en-us/free](https://azure.microsoft.com/en-us/free) and registering for a 3-month trail.

Signing up for a trial requires:

- A unique Microsoft Live Account that has not registered for a trial for in the past
- A Credit Card, used to verify identity and will not be charged unless you opt-in after the trial is over

> If you are having issues with this access, please alert the instructor ASAP as this will prevent you from completing the challenges.

Login with the Azure CLI by running `az login`.

```sh
$ az login
To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code XXXXXXXX to authenticate.
```

Navigate to [https://microsoft.com/devicelogin](https://microsoft.com/devicelogin) and enter the code given in the CLI, then log in using the account that has access to Azure.

Once complete, verify Azure CLI Access by running `az account show -o table`.

```sh
$ az account show -o table
EnvironmentName    IsDefault    Name                             State    TenantId
-----------------  -----------  -------------------------------  -------  ------------------------------------
AzureCloud         True         Visual Studio Premium with MSDN  Enabled  GUID
```

You are now connecting to Azure from the Azure CLI!

As one last step here, login to the [Azure Portal](https://portal.azure.com/), this will be useful to see the resources get created in future challenges.

### Download Terraform

In this workshop we will be using terraform 0.11.7 for all of the challenges.

Navigate to the downloads page [https://releases.hashicorp.com/terraform/0.11.7/](https://releases.hashicorp.com/terraform/0.11.7/) and select the `.zip` file for your operating system.

For **Windows** - [Download Here](https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_windows_amd64.zip)

For **Mac** - [Download Here](https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_darwin_amd64.zip)

Once downloaded, extract the contents which is just a `terraform` binary and copy it to a folder inside your PATH environment variable.

For **Windows** - create a new directory and add it to your PATH environment variable

For **Mac** - typically `/usr/local/bin`

> If you are having issues, more information can be found [here](https://www.terraform.io/intro/getting-started/install.html)

Verify the installation by running `terraform -v`, you should see something like this:

```sh
$ terraform -v
Terraform v0.11.7
```

The latest release can always be found on the [Terraform Website](https://www.terraform.io/downloads.html)

### Download Visual Studio Code

*or any other text editor...*

You can Download the latest version here:

https://code.visualstudio.com/Download

![](../../img/2018-05-09-09-10-24.png)

Optionally you can also install the Terraform Extension [here](https://marketplace.visualstudio.com/items?itemName=mauve.terraform)

### Clone this repository

Install git by going to [here](https://git-scm.com/downloads) and downloading the latest git version.

Once installed, open up a terminal and change directory into a path that you would like to work out of.
Then open the repository in VS Code.

```sh
cd ~/Projects/
git clone https://github.com/CardinalNow/TerraformWorkshop.git
code TerraformWorkshop
```

> If running `code TerraformWorkshop` doesn't launch VS Code, open up VS Code manually and open the folder you cloned the repository to.

### Github Access

If you already have a github account you can skip this step.

Github repositories will be needed to complete some of the later challenges.

Sign up for a free github.com account by going to [https://github.com/join](https://github.com/join) and following the instructions.

Once created, login.
