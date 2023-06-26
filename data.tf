data "azurerm_resource_group" "dns_private_resolver_syd_rg" {
  name = "dns-private-resolver-prod-syd-rg"
}

data "azurerm_resource_group" "dns_private_resolver_mel_rg" {
  name = "dns-private-resolver-prod-mel-rg"
}

data "azurerm_virtual_network" "dns_private_resolver_syd_vnet" {
  name                = "vnet-dns-resolver-syd"
  resource_group_name = "dns-private-resolver-prod-syd-rg"
}

data "azurerm_virtual_network" "dns_private_resolver_mel_vnet" {
  name                = "vnet-dns-resolver-mel"
  resource_group_name = "dns-private-resolver-prod-mel-rg"
}

data "azurerm_subnet" "subnet_outbound_dns_resolver_syd" {
  name                 = "subnet-outbound-dns-resolver-syd"
  virtual_network_name = "vnet-dns-resolver-syd"
  resource_group_name  = "dns-private-resolver-prod-syd-rg"
}

data "azurerm_subnet" "subnet_outbound_dns_resolver_mel" {
  name                 = "subnet-outbound-dns-resolver-mel"
  virtual_network_name = "vnet-dns-resolver-mel"
  resource_group_name  = "dns-private-resolver-prod-mel-rg"
}

data "azurerm_subnet" "subnet_inbound_dns_resolver_syd" {
  name                 = "subnet-inbound-dns-resolver-syd"
  virtual_network_name = "vnet-dns-resolver-syd"
  resource_group_name  = "dns-private-resolver-prod-syd-rg"
}

data "azurerm_subnet" "subnet_inbound_dns_resolver_mel" {
  name                 = "subnet-inbound-dns-resolver-mel"
  virtual_network_name = "vnet-dns-resolver-mel"
  resource_group_name  = "dns-private-resolver-prod-mel-rg"
}