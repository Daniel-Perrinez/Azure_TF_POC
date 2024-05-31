# Configure Azure Provider
provider "azurerm" {
  features {}
}

data "azurerm_subscription" "primary" {
}

data "azurerm_role_definition" "builtin" {
  name = "Contributor"
}

# │ Error: unexpected status 403 (403 Forbidden) with error: AuthorizationFailed: The client 'DanielPerrinez@wei-lab.com' with object id '...' does not have authorization to perform action 'Microsoft.Authorization/roleDefinitions/write' over scope '/subscriptions/.../providers/Microsoft.Authorization/roleDefinitions/...' or the scope is invalid. If access was recently granted, please refresh your credentials.
# resource "azurerm_role_definition" "danp-test-role" {
#   name        = "danp-test-role"
#   scope       = data.azurerm_subscription.primary.id
#   description = "This is a custom role created via Terraform"

#   permissions {
#     actions     = ["*/read"]
#     not_actions = []
#   }

#   assignable_scopes = [
#     data.azurerm_subscription.primary.id,
#   ]
# }


# Using terraform, how do I create an Azure AD (Entra ID) tenant in Microsoft Azure cloud?
# Currently it doesn't seem possible.