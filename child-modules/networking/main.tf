resource "azurerm_virtual_network" "example" {
  for_each = var.vnt
  name                = each.value.vnet_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers

}


resource "azurerm_subnet" "example" {
  for_each = var.sbnt
  name                 = each.value.sbnt_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_security_group" "example" {
  for_each = var.nsgg
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}


resource "azurerm_subnet_network_security_group_association" "example" {
  for_each = var.sbnt
  subnet_id = azurerm_subnet.example[each.key].id

  network_security_group_id = azurerm_network_security_group.example[each.key].id
}


