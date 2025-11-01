locals {
  environment_post_fix = "dev"
  tags = {
    Project     = "<PROJECT_NAME>"
    Client      = var.project_name
    Environment = "Development"
  }
}

module "resource_group" {
  source       = "../../modules/resource_group"
  project_name = var.project_name
  environment  = local.environment_post_fix
  location     = var.location
  tags         = local.tags
}

module "network" {
  source              = "../../modules/network"
  project_name        = var.project_name
  environment         = local.environment_post_fix
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  vnet_cidr           = var.vnet_cidr
  subnet_cidr         = var.subnet_cidr
  tags                = local.tags
  depends_on          = [module.resource_group]
}

module "nic" {
  source              = "../../modules/nic"
  project_name        = var.project_name
  environment         = local.environment_post_fix
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.network.subnet_id
  tags                = local.tags
  depends_on          = [module.network]
}

module "nsg" {
  source                       = "../../modules/nsg"
  project_name                 = var.project_name
  environment                  = local.environment_post_fix
  location                     = module.resource_group.location
  resource_group_name          = module.resource_group.resource_group_name
  azurerm_subnet_id            = module.network.subnet_id
  azurerm_network_interface_id = module.nic.nic_id
  tags                         = local.tags
  depends_on                   = [module.nic]
}

module "vm" {
  source               = "../../modules/vm"
  subscription_id      = var.subscription_id
  project_name         = var.project_name
  environment          = local.environment_post_fix
  location             = module.resource_group.location
  resource_group_name  = module.resource_group.resource_group_name
  nic_id               = module.nic.nic_id
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  golden_image_version = var.golden_image_version
  ssh_public_key_path  = var.ssh_public_key_path
  tags                 = local.tags
  depends_on           = [module.nsg]
}
