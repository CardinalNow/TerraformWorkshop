This contains the general content that will be used to build the presentation.

You can view this file in presentation mode by going [https://gitpitch.com/CardinalNow/TerraformWorkshop](https://gitpitch.com/CardinalNow/TerraformWorkshop).

This content will be converted to a PowerPoint once it is finalized.

---
## Introduction

Purpose of Workshop, what is expected

Who am I, background

Who is Cardinal

Agenda

---
## Introduction to Azure

IaaS, PaaS, Networking.

Resource Groups, group resources together.

---
## Azure Virtual Machine Components

- Virtual Network (VNet)
- Subnet
- (optional) Network Security Group (NSG) and Rules
- Network Interface Card (NIC)
- Virtual Machine
- OS Disk
- (optional) Data Disks

---
## Introduction to IaC

What is it?

How can it help?

Why should I invest in it?

---
## What is Infrastructure as Code

Infrastructure as Code (IaC) is the process of managing and provisioning computer data centers through machine-readable definition files.

---
## Infrastructure as Code

Provide a codified workflow to create infrastructure

Expose a workflow for managing updates to existing infrastructure

Integrate with application code workflows (Git, SCM, Code Review)

Provide modular, sharable components for separation of concerns

---
## Introduction to Terraform

https://www.terraform.io/

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently.

---
## Terraform

[Open Source Software](https://github.com/hashicorp/terraform)

[Go Programming Language](https://golang.org/)

Microsoft Partnership

---
## Terraform

Infrastructure is described using a high-level configuration syntax. This allows a blueprint of your datacenter to be versioned and treated as you would any other code. Additionally, infrastructure can be shared and re-used.

---
## Terraform

Human-readable configuration (HCL) is designed for human consumption so users can quickly interpret and understand their infrastructure configuration.
HCL includes a full JSON parser for machine-generated configurations.

```hcl
resource "azurerm_resource_group" "test" {
  name     = "terraform-test-rg"
  location = "centralus
}
```

---
## Terraform

Basic flow.

- init
- plan
- apply
- destroy

---
## Terraform Azure Provider

Providers are in a different github organization and are versioned and a different cadence than terraform core.

Examples:

https://github.com/terraform-providers/terraform-provider-azurerm/tree/master/examples

---
## Challenge 01 - Connecting to Azure

Connect Terraform on your local machine to your Azure Subscription.

---
## Challenge 02 - Terraform Basics

Run the Terraform workflow.

---
## Terraform Workflow

Init process, pulling in modules, etc.. `./.terraform` folder.

Plan, reading state file.

Apply, updating state file.

---
## Terraform Versions

Terraform Version:

```sh
terraform -v
Terraform v0.11.6
```

Terraform Provider Version

```sh
terraform providers
.
└── provider.azurerm 1.3.0
```

---
## Pro Tip #1

Lock down terraform and terraform provider versions.

```hcl
terraform {
  required_version = "= 0.11.6"
}
```

```hcl
provider "azurerm" {
  version = "1.3.0"
}
```

---
## Terraform Variables

A variable is a user or machine-supplied input in Terraform configurations. Variables can be supplied via environment variables, CLI flags, or variable files. Combined with modules, variables help make Terraform flexible, sharable, and extensible.

Variables

- Must be declared.
- No inheritence.
- Variables are scoped to their current directory.

---
## Terraform Variables

```hcl
variable "location" {
  type        =  "string"
  default     = "centralus"
  description = "The Azure region to deploy infrastructure to."
}
```

Referenced using `${var.location}` syntax.

https://www.terraform.io/docs/configuration/variables.html

---
## Terraform Variable Types

- String
- Boolean
- List
- Map

---
## Terraform Variable Scoping

<insert image showing scoping of variables>

---
## Terraform Setting Variables

- Variable defaults

- Command Line

```sh
terraform plan -var 'myvariable=somevalue' `
  -var 'anothervariable=anothervalue'
```

---
## Terraform Setting Variables

- `terraform.tfvars` file

```sh
myvariable = "somevalue"
anothervariable = "anothervalue"
```

- Environment Variables, start with `TF_VAR_`

```sh
export TF_VAR_myvariable="somevalue"
export TF_VAR_anothervariable="anothervalue"
```

---
## Terraform Count

Most resources support a `count` variable.

---
## Terraform Outputs

Outputs define values that will be highlighted to the user when Terraform applies

```hcl
output "rg-name" {
  value = "${azurerm_resource_group.module.name}"
}
```

Read outputs

```sh
$ terraform output
rg-name = tfvars-rg
```

---
## Challenge 03 - Azure Virtual Machine

In this challenge, you will create a single Virtual Machine and deploy it to Azure.
The VM will include all the networking required and additionally a Public IP to allow access.

---
## Challenge 04 - Terraform Count

In this challenge, you will take what you did in Challenge 03 and expand to take a count variable.

---
## Terraform Modules

Modules are used in Terraform to modularize and encapsulate groups of resources in your infrastructure.

Any Terraform configuration in a directory can be referenced as a module.

```hcl
module "name" {
  source  = ""
  ...
}
```

---
## Terraform Modules Source

A module source can be any of the following:

- Local file paths
- Terraform Registry
- GitHub
- Bitbucket
- Generic Git, Mercurial repositories
- HTTP URLs
- S3 buckets

More information about module sources can be found at [https://www.terraform.io/docs/modules/sources.html](https://www.terraform.io/docs/modules/sources.html)

---
## Terraform Modules Source

The `source` parameter can not be interpolated.

Read during a `terraform init` to determine which providers are needed.

Variable Propagation

---
## Local Module

```hcl
module "consul" {
  source = "./consul"
}
```

__Warning:__ Relative paths are based on where `terraform` was executed!

---
## Github Module

```hcl
module "consul" {
  source = "github.com/hashicorp/example"
}
```

```hcl
module "consul" {
  source = "github.com/hashicorp/example//subdir"
}
```

---
## Terraform Registry Module

The Terraform Registry is an index of modules written by the Terraform community. The Terraform Registry is the easiest way to get started with Terraform and to find modules.

The registry is integrated directly into Terraform. You can reference any registry module with a source string of <NAMESPACE>/<NAME>/<PROVIDER>. Each module's information page on the registry includes its source string.

```hcl
module "compute" {
  source  = "Azure/compute/azurerm"
  version = "1.1.5"

  # insert the 2 required variables here
}
```

Public.

---
## Private Registry

Terraform Enterprise

Versioning.

Credential management.

Easily share across your organization.

---
## Challenge 05 - Terraform Modules

In this challenge, you will create a module to contain a scalable virtual machine deployment, then create an environment where you will call the module.

---
## Challenge 06 - Complex Module

In this challenge, you will dive into a more complex module setup.

(most likely skip this but can reference advanced attendees to take a look)

---
## Configuration

Already talked about variables and outputs. Cover a few of the more commony used configuration items.

- interpolation syntax
- locals
- depends_on
- lifecycle
- data sources

---
## Configuration - Interpolation Syntax

Built-in functions:

- element(list, index)
- contains(list, element)
- format(format, args)
- lookup(map, key, default)

https://www.terraform.io/docs/configuration/interpolation.html

---
## Configuration - locals

Create local variable for reuse to avoid duplication.

```hcl
locals {
  local_name = "${var.name}-${var.location}"
}

resource "azurerm_resource_group" "module" {

  ...

  name = "${local.local_name}-rg"
}

resource "azurerm_virtual_network" "module" {

  ...

  name = "${local.local_name}-vnet"
}
```

---
## Configuration - depends_on

```hcl
resource "azurerm_subnet" "module" {

  ...

  depends_on = ["azurerm_virtual_network.module"]
}
```

---
## Configuration - lifecycle

https://www.terraform.io/docs/internals/lifecycle.html

---
## Working Lunch

---
## Where to run Terraform From?

locally
from the Azure Portal
CI/CD
Terraform Enterprise

---
## Terraform Enterprise

What is TFE?
Why should I use it over just OSS?

---
## Terraform Enterprise Workspaces

Workspaces allow for environment isolation.
Role based access.
Full visibility.

---
## Terraform Enterprise Private Registry

Private Registry with versioning.

---
## Terraform Enterprise Sentinel Integration

What is a policy?

Enforcement Mode.

From the portal.

From an API
https://www.terraform.io/docs/enterprise/api/index.html

---
## Final Thoguhts

- Close out questions
- High level advice
- Pitch the PoC effort.
- Ensure everyone has access to the content.

---



Topics to consider:

- Resource Addressing https://www.terraform.io/docs/internals/resource-addressing.html
- Debugging https://www.terraform.io/docs/internals/debugging.html
- Workspaces https://www.terraform.io/docs/state/workspaces.html
- Remote Backend https://www.terraform.io/docs/state/remote.html
- Running Terraform from the Azure Cloud Shell
- Multiple Provider Example
- Module versioning
- Local Exec
- Remote Exec
- Infrastructure Testing
- Custom images - could use a quick packer example to create an image, then reference it
