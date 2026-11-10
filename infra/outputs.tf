# Values printed after apply; read them with `terraform output`.
# Ansible uses public_ip to know where to connect.

output "public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

output "admin_username" {
  value = var.admin_username
}
