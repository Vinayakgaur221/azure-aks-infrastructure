variable "kbcl" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = string
    node_count          = number
    vm_size             = string
    vnet_subnet_id      = string
    tags                = map(string)
  }))
}