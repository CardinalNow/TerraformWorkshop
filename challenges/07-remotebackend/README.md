# 07 - Remote Backend

## Expected Outcome

In this challenge, you will move your state file to a remote backend.

## How to

### Create Azure Storage Account

In the Portal, create a SA.

Get the account information, including SAS token.

Create a Blob Container

### Config Backend

Update your configuration with the info:

```hcl
terraform {
    backend {
        account = ""
        key = ""
        name = ""
    }
}
```

Run `terraform init`.

### View Lock State

Run a plan and view the file in the portal, notice how a lease is put on it.
