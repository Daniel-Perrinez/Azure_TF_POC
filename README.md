# Azure_TF_POC
A place for Azure Terraform

### A quick tool for converting AWS IAM policies to TF
https://iampolicyconverter.com

### AWS IAM policies in TF
https://developer.hashicorp.com/terraform/tutorials/aws/aws-iam-policy

<!-- This may be the Azure analogue for AWS IAM  -->
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition

<!-- Terraform Import will find the existing resource from ID and import it into your Terraform state
Note: this doesn't give you any code, but when you run terraform plan you can check your changes against what's in production.
 -->
https://developer.hashicorp.com/terraform/cli/commands/import



### Notes on AWS IAM migrate to Azure policies POC
- Azure subscription: is a logical unit of Azure services that allows you to provision and manage Azure resources like virtual machines, storage accounts, databases, etc.

- Azure Tenant (Azure AD Tenant): 
    - An Azure tenant is a dedicated instance of Azure Active Directory (Azure AD) that represents a single organization .
    - It is the core directory service that handles identity and access management for Azure subscriptions and resources

To run TF on Azure follow these steps:

1. 
    ```
    az account set --subscription "<SUBSCRIPTION_ID>"
    az login
    ```
    If needed, install the AZ cli tool: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-macos
    [az cli docs](https://learn.microsoft.com/en-us/cli/azure/)

2. Create a Service Principal if one does not already exist
    ```
    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
    ```

3. Workflow
terraform init
terraform plan
terraform apply -auto-approve

