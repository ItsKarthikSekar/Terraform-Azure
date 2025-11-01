output "nsg_id" {
  value = azurerm_network_security_group.this.id
}

output "nsg_name" {
  value = azurerm_network_security_group.this.name
}

output "nsg_location" {
  value = azurerm_network_security_group.this.location
}
