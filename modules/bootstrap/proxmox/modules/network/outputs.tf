output "zone_id" {
  value = proxmox_sdn_zone_vlan.this.id
}

output "vnet_id" {
  value = proxmox_sdn_vnet.this.id
}
