output "container_id" {
  value = proxmox_virtual_environment_container.this.id
}

output "ip_address" {
  value = var.ip_address
}

output "debug_template" {
  value = data.proxmox_virtual_environment_containers.template.containers
}
