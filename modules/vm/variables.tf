variable "subscription_id" { type = string }
variable "project_name" { type = string }
variable "environment" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "nic_id" { type = string }

variable "vm_size" {
  type    = string
  default = "Standard B2s"
}

variable "admin_username" {
  type    = string
  default = "azuredevadmin"
}

variable "golden_image_version" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
