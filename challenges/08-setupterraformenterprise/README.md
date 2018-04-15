# 08 - Setup Terraform Enterprise

## Expected Outcome

In this challenge, you will connect to your Terraform Enterprise.


## How to

### Create a Trial Account

Register for a [Terraform Enterprise Trial](https://app.terraform.io/account/new?trial=terraform).
![](../../img/2018-04-14-12-58-33.png)

### Create a New Organization

Pick a name that includes your name. Example: 'tstraubworkshop'

![](../../img/2018-04-14-12-59-54.png)

> __Note:__ Organization must be globally unique.

### Create a New Workspace

Pick a name that indicates the intent of the infrastructure. Example: 'app-dev'

![](../../img/2018-04-14-13-10-52.png)

### Setup VCS

Connect Terraform Enterprise to your source control.

![](../../img/2018-04-14-13-21-32.png)

Follow the instructions for any of the following VSC providers:

- [Github](https://www.terraform.io/docs/enterprise/vcs/github.html)
- [Github Enterprise](https://www.terraform.io/docs/enterprise/vcs/github-enterprise.html)
- [GitLab](https://www.terraform.io/docs/enterprise/vcs/gitlab-com.html)
- [GitLab EE and CE](https://www.terraform.io/docs/enterprise/vcs/gitlab-eece.html)
- [Bitbucket Cloud](https://www.terraform.io/docs/enterprise/vcs/bitbucket-cloud.html)
- [Bitbucket Server](https://www.terraform.io/docs/enterprise-legacy/index.html)

### Connect Workspace

Connect your workspace to your VCS.

![](../../img/2018-04-14-14-04-56.png)

Set working directory and branch properly!

### Configure Variables

Set a the Terraform Variable "name" to some unique name. Example "app-dev".

Set Environment Variables for your Azure Service Prinipal (be sure check the 'sensative' checkbox to hide these values):

- ARM_TENANT_ID
- ARM_SUBSCRIPTION_ID
- ARM_CLIENT_ID
- ARM_CLIENT_SECRET

![](../../img/2018-04-14-14-10-32.png)

### Run a Plan

Click the "Queue Plan" button.
![](../../img/2018-04-14-14-12-05.png)


### View the Plan

![](../../img/2018-04-14-14-13-01.png)


### Run an Apply

Enter a comment and then Apply.

![](../../img/2018-04-14-14-13-52.png)

### View the Apply

![](../../img/2018-04-14-14-15-02.png)


## Advanced areas to explore

1. Add another folder in the repo for 'app-prod' and create another workspace with different settings.

## Resources

- [TFE Access](https://www.terraform.io/docs/enterprise/getting-started/access.html)
