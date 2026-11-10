# Values printed after apply; read them with `terraform output`.
# Ansible uses public_ip to know where to connect.

output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "admin_username" {
  value = var.admin_username
}

# Ansible inventory, generated from the real IP:
# terraform output -raw ansible_inventory > ../ansible/inventory.ini
output "ansible_inventory" {
  value = <<-EOT
    [web]
    ${azurerm_public_ip.pip.ip_address}
  EOT
}
