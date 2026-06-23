output "scoped_token" {
  value     = module.token.scoped_token
  sensitive = true
}

output "token_id" {
  value = module.token.token_id
}

output "pool_id" {
  value = proxmox_virtual_environment_pool.this.pool_id
}

output "zone_id" {
  value = module.network.zone_id
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "storage_id" {
  value = var.storage_id
}
