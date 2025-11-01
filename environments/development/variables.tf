variable "subscription_id" {
  description = "Azure Subscription ID for bootstrap resources"
  type        = string
}

variable "project_name" {
  description = "Project name used for naming bootstrap resources"
  type        = string
}

variable "location" {
  description = "Azure location for bootstrap resources"
  type        = string
  default     = "Sweden Central"
}

variable "vnet_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.1.1.0/24"
}

variable "vm_size" {
  type    = string
  default = "Standard_B2als_v2"
}

variable "admin_username" {
  type    = string
  default = "adminuser"
}

variable "golden_image_version" {
  type    = string
  default = "1.0.0"
}

variable "ssh_public_key_path" { type = string }

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}
