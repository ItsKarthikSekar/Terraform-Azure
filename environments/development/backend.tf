terraform {
  backend "azurerm" {
    resource_group_name  = "rg-archie-tfstate"
    storage_account_name = "<STORAGE_ACCOUNT_FROM_BOOTSTRAP>"
    container_name       = "tfstate"
    key                  = "development.terraform.tfstate"
    use_azuread_auth     = true
  }
}
