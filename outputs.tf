output "vm_aws_ip" {
  description = "IP da maquina AWS"
  value       = aws_instance.vm.public_ip
}

output "vm_azure_ip" {
  description = "IP da maquina Azure"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}

# output "security_group_id" {
#   value = aws_security_group.security_group.id
# }