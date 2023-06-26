resource "azurerm_private_dns_resolver" "dns_private_resolver_prod" {
  name                = var.global_parameters.name
  resource_group_name = var.global_parameters.resource_group.name
  location            = var.global_parameters.resource_group.location
  virtual_network_id  = var.global_parameters.vnet_id
  tags                = var.global_parameters.tags
  timeouts {
    read = "30m"
  }  
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "dns_private_resolver_outbound_endpoint" {
  name                      = join("-", [var.global_parameters.name, "outbound-endpoint"])
  private_dns_resolver_id   = azurerm_private_dns_resolver.dns_private_resolver_prod.id
  location                  = azurerm_private_dns_resolver.dns_private_resolver_prod.location
  subnet_id                 = var.global_parameters.outbound_subnet.id
  tags                      = var.global_parameters.tags
  timeouts {
    read = "30m"
  }
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "dns_private_resolver_inbound_endpoint" {
  name                      = join("-", [var.global_parameters.name, "inbound-endpoint"])
  private_dns_resolver_id   = azurerm_private_dns_resolver.dns_private_resolver_prod.id
  location                  = azurerm_private_dns_resolver.dns_private_resolver_prod.location
  tags                      = var.global_parameters.tags
  dynamic "ip_configurations" {
    for_each = var.global_parameters.inbound_subnet
    content {
      private_ip_allocation_method = ip_configurations.value["private_ip_allocation_method"]
      subnet_id                    = ip_configurations.value["subnet_id"]
    } 
  }
  timeouts {
    read = "30m"
  }
}

resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "example" {
  for_each                                      = {
    for count, ruleset in var.global_parameters.dns_forwarding_rule_set : ruleset.ruleset_name => ruleset      
  }
  name                                          = join("-", [var.global_parameters,name, each.key])
  resource_group_name                           = azurerm_resource_group.example.name
  location                                      = azurerm_resource_group.example.location
  private_dns_resolver_outbound_endpoint_ids    = [azurerm_private_dns_resolver_outbound_endpoint.example.id]
  tags                      = var.global_parameters.tags
  timeouts {
    read = "30m"
  }
}
