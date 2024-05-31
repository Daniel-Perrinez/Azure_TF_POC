# Configure Azure Provider
provider "azurerm" {
  features {}
}

# Azure Subscription
data "azurerm_subscription" "current" {
}
output "azurerm_subscription" {
  value = data.azurerm_subscription.current.display_name
}

# Management Group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group
data "azurerm_management_group" "mgmt-group" {
    name = "Terraform-mgmt"
}
output "azurerm_management_group" {
  value = data.azurerm_management_group.mgmt-group.display_name
}

# Policy -- like a role but only at the Management Group level
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_policy_assignment
resource "azurerm_policy_definition" "danp-test-policy" {
  name                = "only-deploy-in-EastUS"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "danp-policy-definition"
  management_group_id = data.azurerm_management_group.mgmt-group.id

  policy_rule = <<POLICY_RULE
 {
    "if": {
      "not": {
        "field": "location",
        "equals": "EastUS"
      }
    },
    "then": {
      "effect": "Deny"
    }
  }
POLICY_RULE
}

resource "azurerm_management_group_policy_assignment" "mgmt-group" {
  name                 = "danp-policy-assignment"
  policy_definition_id = azurerm_policy_definition.danp-test-policy.id
  management_group_id  = data.azurerm_management_group.mgmt-group.id
}



# Access control (IAM) role 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition
resource "azurerm_role_definition" "danp-test-role" {
  name        = "danp-test-role"
  scope       = data.azurerm_subscription.current.id
  description = "This is a custom role created via Terraform"

  permissions {
    actions     = ["*/read"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id,
  ]
}




# Using terraform, how do I create an Azure AD (Entra ID) tenant in Microsoft Azure cloud?
# a tenant refers to a dedicated and trusted instance of the Microsoft Entra ID service that represents a single organization.
# Currently it doesn't seem possible.