resource "azurerm_log_analytics_workspace" "example" {
    for_each = var.mntr
  name                = each.value.anws_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku_name
  retention_in_days   = each.value.retention_in_days
}

