terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.44.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}


resource "azurerm_resource_group" "example" {
  name     = "rg-test-example"
  location = "West Europe"
}