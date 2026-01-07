# Output the Public IP to use in Ansible inventory
output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}

# Output the VM Name for reference
output "vm_name" {
  description = "Name of the Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.name
}

# Output the Resource Group Name
output "resource_group_name" {
  description = "Resource Group where the VM is located"
  value       = azurerm_resource_group.rg.name
}