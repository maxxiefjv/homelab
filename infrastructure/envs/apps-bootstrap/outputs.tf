# These tokens are handed to app teams after bootstrap runs.
# Each team puts their scoped token in their local.tfvars as proxmox_api_token.

output "oktobus_token" {
  description = "Scoped API token for oktobus — hand to the oktobus team"
  value       = module.oktobus.scoped_token
  sensitive   = true
}

output "oktobus_pool_id" {
  value = module.oktobus.pool_id
}

output "oktobus_zone_id" {
  value = module.oktobus.zone_id
}

output "oktobus_vnet_id" {
  value = module.oktobus.vnet_id
}

output "oktobus_storage_id" {
  value = module.oktobus.storage_id
}

output "app_2_token" {
  description = "Scoped API token for app-2 — hand to the app-2 team"
  value       = module.app_2.scoped_token
  sensitive   = true
}

output "app_2_pool_id" {
  value = module.app_2.pool_id
}

output "app_2_zone_id" {
  value = module.app_2.zone_id
}

output "app_2_vnet_id" {
  value = module.app_2.vnet_id
}

output "app_2_storage_id" {
  value = module.app_2.storage_id
}
