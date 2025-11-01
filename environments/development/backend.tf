terraform {
  backend "azurerm" {
    resource_group_name  = "rg-master-tfstate"
    storage_account_name = "mastertfstatetbo9am"
    container_name       = "tfstate"
    key                  = "development.terraform.tfstate"
    use_azuread_auth     = true
  }
}
