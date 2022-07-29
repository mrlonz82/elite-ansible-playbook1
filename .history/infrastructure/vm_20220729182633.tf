resource "azurerm_resource_group" "elite_general_resources" {
  name     = var.elite_general_resources
  location = var.location
}
resource "azurerm_network_interface" "labnic" {
  name                = join("-", [local.server, "lab", "nic"])
  location            = local.buildregion
  resource_group_name = azurerm_resource_group.elite_general_resources.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.application_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.labpip.id
  }
}

resource "azurerm_public_ip" "labpip" {
  name                = join("-", [local.server, "lab", "pip"])
  resource_group_name = azurerm_resource_group.elite_general_resources.name
  location            = local.buildregion
  allocation_method   = "Static"

  tags = local.common_tags
}


resource "azurerm_linux_virtual_machine" "Linuxvm" {
  name                = join("-", [local.server, "linux", "vm"])
  resource_group_name = azurerm_resource_group.elite_general_resources.name
  location            = local.buildregion
  size                = "Standard_DS1"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.labnic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEMBf796itesdzYjfzVpKQeg6+Rl5saeoAwMMUHn34eOsDD5uuAyKNkSuPf8SbDHNlp1826jVeNBl2y9PO3ynbfE+MD4kolp20kZ+GRmsb2UZ5NrNA/BQ1oKsvCrUB8LtCOb2TDQ6vHMi4Hf6hVenRjupZyoWFhCcIOR2Khp6Bz9wj2xGLWNUeaX3R3spX/M5UXvfPQ/4Nwx3QeTplouslPXHlk911c3JElQJoA1pu2bTw1MV5MJOTyxia/tK6eIW8chfRqVGA4ofETcecgoiVvYv6MQQXzsvYtD8DZ6ezE6waYFp5SdhehnHbDmBdfQNcJveoLmUowJFYBU3U3dYOZsr6bzASEwHpDGPMhmAcANH/qYUD6mUlDdSMkUgM0GvAW36QnY7JUWwaBM/48KiLJJWykFt3XtAYMjLBZAPGA5rqDyBk7OiGFTxdnn3ak2EIInHDG89dtqHy/GDrdvKD5+eignp6mf0oqbYPAE2F7RNvCnNkYJAgeLj7YZlSJ3s= devopslab@DESKTOP-ESPF26I"

  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    offer     = "0001-com-ubuntu-server-focal"
    publisher = "Canonical"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}