variable "project_name" { type = string }
variable "environment" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "azurerm_subnet_id" { type = string }
variable "azurerm_network_interface_id" { type = string }
variable "tags" {
  type    = map(string)
  default = {}
}
