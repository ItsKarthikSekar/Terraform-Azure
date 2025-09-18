terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.44.0"
    }
  }
}

provider "azurerm" {
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "tfstate" {
  name     = "rg-${var.project_name}-tfstate"
  location = var.location
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "azurerm_storage_account" "tfstate" {
  name                     = lower("${var.project_name}tf${random_string.suffix.result}")
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

resource "azurerm_key_vault" "tfstate" {
  name                = "kv-${var.project_name}-tfstate"
  location            = azurerm_resource_group.tfstate.location
  resource_group_name = azurerm_resource_group.tfstate.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  purge_protection_enabled = true
}

resource "azurerm_key_vault_secret" "storage_key" {
  name         = "tfstate-storage-key"
  value        = azurerm_storage_account.tfstate.primary_access_key
  key_vault_id = azurerm_key_vault.tfstate.id
}

# Give the current principal permission to use the storage account (blob data contributor)
resource "azurerm_role_assignment" "tfstate_storage_contributor" {
  scope                = azurerm_storage_account.tfstate.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
