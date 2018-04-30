# Building Azure infrastructure using Terraform and Terraform Enterprise Challenge Guide

Below is a series of "challenges" or guided exercises to help attendees learn about Terraform and how to use it to create Azure Resources. These are not meant the be "hands-on labs" or step-by-step guides. The goal is to provide a series of exercises that have an expected outcome. Some steps and code will be provided. In the end, the hands-on experience should lead to a deeper level of learning.

## Environment Setup

For the Workship event, attendees will be provided a 30-day trial of Terraform Entrprise.

__Prerequisites to bring to the event__

- Laptop
- Azure account with access to deploy at least 10 cores and at least contributor access
- [Azure Service Principal](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?toc=%2Fazure%2Fazure-resource-manager%2Ftoc.json&view=azure-cli-latest#create-a-service-principal-for-your-application) Needed for Terraform Enterprise Challenges
- Github Account (Free)

__Setup__

- [Terraform](https://www.terraform.io/downloads.html) Latest should work, content was created with v0.11.4
- [Azure CLI 2.0](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
- [Visual Studio Code](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) (or your favorite text editor)
    - [VSCode Terraform Extension](https://github.com/mauve/vscode-terraform)
- [git](https://git-scm.com/downloads)
- Clone this repo `git clone https://github.com/CardinalNow/TerraformWorkshop.git`

## Challenges

For each challenge, change your working directory to the folder for that challenge. 
Each challenge is meant to be independent of each other.
If you get stuck, refer to the `solutions` directory for a working solution to the challenge.

### Challeng 01: [Connecting to Azure](challenges/01-connectingtoazure/README.md)

### Challeng 02: [Terraform Basics](challenges/02-terraformbasics/README.md)

### Challeng 03: [Azure Virtual Machine](challenges/03-azurevm/README.md)

### Challeng 04: [Terraform Count](challenges/04-terraformcount/README.md)

### Challeng 05: [Terraform Modules](challenges/05-terraformmodules/README.md)

### Challeng 06: [Advanced Terraform Modules](challenges/06-advancedmodules/README.md)

### Challeng 07: [Remote Backend](challenges/07-remotebackend/README.md)

### Challeng 08: [Setup Terraform Enterprise](challenges/08-setupterraformenterprise/README.md)

### Challeng 09: [Private Module Registry](challenges/09-privatemoduleregistry/README.md)

### Challeng 10: [Sentinel Policy](challenges/10-value/README.md)
