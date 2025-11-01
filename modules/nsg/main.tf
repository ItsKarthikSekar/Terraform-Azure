resource "azurerm_network_security_group" "this" {
  name                = "nsg-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "inbound_rules" {
  for_each = {
    AllowAnyHTTPInbound = {
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow HTTP inbound"
    }
    AllowAnyHTTPSInbound = {
      priority                   = 130
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow HTTPS inbound"
    }
    AllowVincentsSSHInbound = {
      priority                   = 140
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "212.187.51.93"
      destination_address_prefix = "*"
      description                = "Allow Vincents IP SSH inbound"
    }
    AllowOfficeLANSSHInbound = {
      priority                   = 150
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "80.113.4.94"
      destination_address_prefix = "*"
      description                = "Allow Office LAN SSH inbound"
    }
    AllowOfficeWifiSSHInbound = {
      priority                   = 160
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "217.100.120.218"
      destination_address_prefix = "*"
      description                = "Allow Office Wifi SSH inbound"
    }
    AllowKarthisIPAddressSSHInbound = {
      priority                   = 170
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "83.84.6.213"
      destination_address_prefix = "*"
      description                = "Allow Karthis IP SSH inbound"
    }
    AllowTagSSHInbound = {
      priority                   = 181
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "AzureCloud"
      destination_address_prefix = "*"
      description                = "Allow Tag SSH inbound"
    }
  }

  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this.name
  description                 = each.value.description
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = var.azurerm_subnet_id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = var.azurerm_network_interface_id
  network_security_group_id = azurerm_network_security_group.this.id
}
