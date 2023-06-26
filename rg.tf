resource "azurerm_resource_group" "dns_private_resolver_syd_rg" {
  name     = "dns-private-resolver-prod-syd-rg"
  location = "australiaeast"
}

resource "azurerm_resource_group" "dns_private_resolver_mel_rg" {
  name     = "dns-private-resolver-prod-mel-rg"
  location = "australiasoutheast"
}