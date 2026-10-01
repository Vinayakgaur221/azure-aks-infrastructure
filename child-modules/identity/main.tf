resource "azurerm_user_assigned_identity" "example" {

  for_each = var.uai

  location            = each.value.location
  name                = each.value.uaasid_name
  resource_group_name = each.value.resource_group_name
}


resource "azurerm_federated_identity_credential" "example" {

  for_each = var.fic

  name = each.value.name

  audience = [
    "api://AzureADTokenExchange"
  ]

  issuer = each.value.issuer

  user_assigned_identity_id = azurerm_user_assigned_identity.example[each.value.uai_key].id

  subject = "system:serviceaccount:${each.value.namespace}:${each.value.service_account_name}"
}


resource "azurerm_role_assignment" "example" {

  for_each = var.ra

  scope                = each.value.scope
  role_definition_name = each.value.role_definition_name
  principal_id         = azurerm_user_assigned_identity.example[each.value.uai_key].principal_id
}