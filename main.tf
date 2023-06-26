locals {
  # Common tags to be assigned to all resources
  tags        = {}
  extra_tags  = {}
  dns_forwarding_rule_set = jsondecode(file("${path.module}/dns_forwarding_ruleset.json"))
}

module "dns-private-resolver-syd" {
  source = "./modules/dns-private-resolver"
  global_parameters = {
    name                    = "dns-private-resolver-prod-syd"
    resource_group          = data.azurerm_resource_group.dns_private_resolver_syd_rg
    dns_forwarding_rule_set = local.dns_forwarding_rule_set
    tags                    = merge(local.tags, local.extra_tags)
    vnet_link_list          = []
    vnet_id                 = data.azurerm_virtual_network.dns_private_resolver_syd_vnet.id
    inbound_subnet          = [{
      private_ip_allocation_method = "Dynamic"
      subnet_id                    = data.azurerm_subnet.subnet_inbound_dns_resolver_syd.id
    }]
    outbound_subnet          = data.azurerm_subnet.subnet_outbound_dns_resolver_syd
  }
}

module "dns-private-resolver-mel" {
  source = "./modules/dns-private-resolver"
  global_parameters = {
    name                    = "dns-private-resolver-prod-mel"
    resource_group          = data.azurerm_resource_group.dns_private_resolver_mel_rg
    dns_forwarding_rule_set = local.dns_forwarding_rule_set
    tags                    = merge(local.tags, local.extra_tags)
    vnet_link_list          = []
    vnet_id                 = data.azurerm_virtual_network.dns_private_resolver_mel_vnet.id
    inbound_subnet          = [{
      private_ip_allocation_method = "Dynamic"
      subnet_id                    = data.azurerm_subnet.subnet_inbound_dns_resolver_mel.id
    }]
    outbound_subnet          = data.azurerm_subnet.subnet_outbound_dns_resolver_mel
  }
}
