# 1. Terraform & Provider Configuration
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Reemplaza con tu ID si es necesario, o déjalo así si usas 'az login'
  subscription_id = "9747e312-3f8b-4de2-af52-b1f56c1d3eaf" 
}

# 2. Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-hybrid-automation"
  location = "West Europe"
}

# 3. Networking
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-prod"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "snet-web"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 4. Public IP (Dynamic to save costs)
resource "azurerm_public_ip" "pip" {
  name                = "pip-web-server"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# 5. Network Interface (NIC)
resource "azurerm_network_interface" "nic" {
  name                = "nic-web-server"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

# 6. Virtual Machine (Standard_B1s = Free Tier)
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-web-server"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  admin_username      = "inaki"

  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_ssh_key {
    username   = "inaki"
    public_key = file("/home/inaki/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}