# 08 - Setup Terraform Enterprise

## Expected Outcome

In this challenge, you will create your Terraform Enterprise trial and your first workspace to build infrastructure in Azure.

This challenge will require that you have a github account so that you can fork repositories. Be sure to login before beginning.

## How to

### Fork the Repository

Open up a browser and navigate to the pre-built repository https://github.com/azure-terraform-workshop/azureworkshop-workspaces.

In the top right, click the `Fork` button.

![](../../img/2018-05-10-17-14-51.png)

Follow the prompts which will fork the repository into your own space you control.

> Note: We need to fork this repository to allow you to connect it to Terraform Enterprise which will create webhooks to get vital information about how and when the repository changes.

You should land in your forked version of the repository.

![](../../img/2018-05-10-17-17-27.png)


### azureworkshop-workspaces repository

There is not much to this repository, just a couple folders that we will use in the next few challenges.

**app-dev** - Simple set of infrastructure to deploy from Terraform Enterprise.

**app-dev-modules** - More complex set infrastructure utilizing the Private Module Registry. Ignore this for now, we will use this in the next Challenge.

### Create a Trial Account for Terraform Enterprise

Register for a [Terraform Enterprise Trial](https://app.terraform.io/account/new?trial=terraform).
![](../../img/2018-04-14-12-58-33.png)

If you are working on this today with others from your organization, you can create a single trial and work together through the last few challenges.

### Create a New Organization

Pick a name that includes your name. Example: 'tstraubworkshop'

![](../../img/2018-04-14-12-59-54.png)

> __Note:__ Organization must be globally unique.

Verify you can login to your Terraform Enterprise organization.

Now you are ready to start using Terraform Enterprise!

### Create a New Workspace

Click the "New Workspace" button.

Pick a name that indicates the intent of the infrastructure. Example: 'app-dev'

![](../../img/2018-04-14-13-10-52.png)

### Setup VCS

<!-- ![](../../img/2018-04-14-13-21-32.png) -->

You won't have any "Source" options, so click the "+" button to connect Terraform Enterprise to your source control.  You will see the following screen asking you to add a VCS root.  Click the "Add VCS Provider" button to continue:

![](../../img/2018-05-11-11-22-22.png)

You will be brought to the Add VCS Provider page:

![](../../img/2018-05-11-11-26-22.png)

Follow the instructions for any of the following VCS providers (we are going to be using Github):

- [Github](https://www.terraform.io/docs/enterprise/vcs/github.html)
- [Github Enterprise](https://www.terraform.io/docs/enterprise/vcs/github-enterprise.html)
- [GitLab](https://www.terraform.io/docs/enterprise/vcs/gitlab-com.html)
- [GitLab EE and CE](https://www.terraform.io/docs/enterprise/vcs/gitlab-eece.html)
- [Bitbucket Cloud](https://www.terraform.io/docs/enterprise/vcs/bitbucket-cloud.html)
- [Bitbucket Server](https://www.terraform.io/docs/enterprise-legacy/index.html)

> Note: This only has to be done once for each Version Control Provider.

> Note: You will need to update your placeholder URL to successfully connect/create your GitHub VCS root.  Make sure you grab your authorization callback URL from GitHub as defined in Step 3 of the instructions for GitHub above.  You may not see the menus described in Step 2.

After this is done, you may have to go back and create your workspace if you didn't do so before you created the VCS provider.  You can do so by navigating to the Workspaces tab at the top of the page and clicking the "New Workspace" button, choosing your GitHub VCS provider during creation.

### Connect Workspace

Connect your workspace to your VCS.

![](../../img/2018-04-14-14-04-56.png)

Set working directory and branch properly!

### Configure Variables

Now that you have a workspace, navigate to the variables.

Set a the Terraform Variable "name" to something unique. Example "app-dev". Click "Save".

Set Environment Variables for your Azure Service Principal (be sure check the 'sensitive' checkbox to hide these values):

- ARM_TENANT_ID
- ARM_SUBSCRIPTION_ID
- ARM_CLIENT_ID
- ARM_CLIENT_SECRET

> Note: You used commands to get/set this information in Step 1 [here.](../01-connectingtoazure/README.md)  Refer back to it if you need to refresh your memory.

> Note: Remember also that some aliases/commands don't work as expected from a Windows cmd shell; if you have any issues with the commands you can try to run them either in the Git bash or PowerShell.

Click "Save".

![](../../img/2018-04-14-14-10-32.png)

### Run a Plan

Click the "Queue Plan" button.
![](../../img/2018-04-14-14-12-05.png)

### View the Plan

![](../../img/2018-04-14-14-13-01.png)

### Run an Apply

Enter a comment and then apply by clicking "Confirm & Apply".

![](../../img/2018-04-14-14-13-52.png)

### View the Apply

![](../../img/2018-04-14-14-15-02.png)

## Advanced areas to explore

1. Explore state versions after the apply.
1. Add another folder in the repository for 'app-prod' and create another workspace with different settings.
1. Push a change to the repository with the workspaces in it, what happens in Terraform Enterprise?

## Resources

- [TFE Access](https://www.terraform.io/docs/enterprise/getting-started/access.html)
