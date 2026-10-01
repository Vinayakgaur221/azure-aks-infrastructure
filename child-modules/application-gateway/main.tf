resource "azurerm_public_ip" "example" {

  for_each = var.pblc

  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  allocation_method = each.value.allocation_method
  sku               = "Standard"
}


resource "azurerm_application_gateway" "network" {

  for_each = var.appg

  name                = each.value.apl_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = each.value.sku_name
    tier     = each.value.tier
    capacity = each.value.capacity
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = each.value.subnet_id
  }

  frontend_port {
    name = each.value.frontend_port_name
    port = each.value.port
  }

  frontend_ip_configuration {
    name = each.value.frontend_ip_configuration_name

    public_ip_address_id = data.azurerm_public_ip.example[each.key].id
  }

  backend_address_pool {
    name = each.value.backend_address_pool_name
  }

  backend_http_settings {
    name                  = each.value.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name = each.value.listener_name

    frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
    frontend_port_name              = each.value.frontend_port_name
    protocol                        = "Http"
  }

  request_routing_rule {
    name                        = each.value.request_routing_rule_name
    priority                    = each.value.priority
    rule_type                   = "Basic"
    http_listener_name          = each.value.listener_name
    backend_address_pool_name   = each.value.backend_address_pool_name
    backend_http_settings_name  = each.value.http_setting_name
  }
}