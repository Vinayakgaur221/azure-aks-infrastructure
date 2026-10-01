resource "azurerm_kubernetes_cluster" "example" {

  for_each = var.kbcl

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix

  default_node_pool {
    name           = "default"
    node_count     = each.value.node_count
    vm_size        = each.value.vm_size
    vnet_subnet_id = each.value.vnet_subnet_id
  }

  node_provisioning_profile {
    mode = "Manual"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  tags = each.value.tags
}
