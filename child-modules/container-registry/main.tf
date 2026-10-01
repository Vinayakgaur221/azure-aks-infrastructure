resource "azurerm_container_registry" "acr" {
    for_each = var.contrg
  name                = each.value.contary_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.cont_sku_name
  admin_enabled       = false
  georeplications {
    location                        = each.value.geo_location
    global_endpoint_routing_enabled = true
    zone_redundancy_enabled         = true
    tags                            = {}
  }
  
}
