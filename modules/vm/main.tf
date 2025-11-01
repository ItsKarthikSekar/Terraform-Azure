resource "azurerm_linux_virtual_machine" "this" {
  name                            = "vm-${var.project_name}-${var.environment}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  network_interface_ids           = [var.nic_id]
  disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = "/subscriptions/${var.subscription_id}/resourceGroups/<RESOURCE_GROUP_NAME>/providers/Microsoft.Compute/galleries/<GALLERY_NAME>/images/<IMAGE_NAME>/versions/${var.golden_image_version}"

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  tags = var.tags
}
