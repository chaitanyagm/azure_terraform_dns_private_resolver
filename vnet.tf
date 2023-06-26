resource "azurerm_virtual_network" "vnet_dns_resolver_syd" {
  name                = "vnet-dns-resolver-syd"
  resource_group_name = azurerm_resource_group.dns_private_resolver_syd_rg.name
  location            = azurerm_resource_group.dns_private_resolver_syd_rg.location
  address_space       = ["10.1.0.0/20"]
}

resource "azurerm_virtual_network" "vnet_dns_resolver_mel" {
  name                = "vnet-dns-resolver-mel"
  resource_group_name = azurerm_resource_group.dns_private_resolver_mel_rg.name
  location            = azurerm_resource_group.dns_private_resolver_mel_rg.location
  address_space       = ["10.2.0.0/20"]
}

resource "azurerm_subnet" "subnet_outbound_dns_resolver_syd" {
  name                 = "subnet-outbound-dns-resolver-syd"
  resource_group_name  = azurerm_resource_group.dns_private_resolver_syd_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_dns_resolver_syd.name
  address_prefixes     = ["10.1.0.64/28"]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

resource "azurerm_subnet" "subnet_outbound_dns_resolver_mel" {
  name                 = "subnet-outbound-dns-resolver-mel"
  resource_group_name  = azurerm_resource_group.dns_private_resolver_mel_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_dns_resolver_mel.name
  address_prefixes     = ["10.2.0.64/28"]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

resource "azurerm_subnet" "subnet_inbound_dns_resolver_syd" {
  name                 = "subnet-inbound-dns-resolver-syd"
  resource_group_name  = azurerm_resource_group.dns_private_resolver_syd_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_dns_resolver_syd.name
  address_prefixes     = ["10.1.0.0/28"]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}

resource "azurerm_subnet" "subnet_inbound_dns_resolver_mel" {
  name                 = "subnet-inbound-dns-resolver-mel"
  resource_group_name  = azurerm_resource_group.dns_private_resolver_mel_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_dns_resolver_mel.name
  address_prefixes     = ["10.2.0.0/28"]

  delegation {
    name = "Microsoft.Network.dnsResolvers"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = "Microsoft.Network/dnsResolvers"
    }
  }
}