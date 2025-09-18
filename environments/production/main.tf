locals {
  tags = {
    Project     = var.project_name
    Environment = "prod"
  }
}

module "resource_group" {
  source       = "../../modules/resource_group"
  project_name = var.project_name
  environment  = "prod"
  location     = var.location
  tags         = local.tags
}

module "network" {
  source              = "../../modules/network"
  project_name        = var.project_name
  environment         = "prod"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  vnet_cidr           = var.vnet_cidr
  subnet_cidr         = var.subnet_cidr
  tags                = local.tags
}

module "nic" {
  source              = "../../modules/nic"
  project_name        = var.project_name
  environment         = "prod"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.network.subnet_id
  tags                = local.tags
}

module "vm" {
  source              = "../../modules/vm"
  project_name        = var.project_name
  environment         = "prod"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  nic_id              = module.nic.nic_id
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  tags                = local.tags
}
