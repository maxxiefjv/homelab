output "container_id" {
  value = proxmox_virtual_environment_container.this.id
}

output "ip_address" {
  value = var.ip_address
}
