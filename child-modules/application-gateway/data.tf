data "azurerm_client_config" "current" {}

data "azurerm_public_ip" "example" {
  for_each = var.appg

  name                = "pip-aks-dev-01"
  resource_group_name = each.value.resource_group_name
}