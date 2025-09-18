terraform {
  backend "azurerm" {
    resource_group_name  = "rg-archie-tfstate"          # if you used project_name=archie for bootstrap
    storage_account_name = "<STORAGE_ACCOUNT_FROM_BOOTSTRAP>"
    container_name       = "tfstate"
    key                  = "production.terraform.tfstate"
    use_azuread_auth     = true
  }
}
