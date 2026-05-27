terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.107.0"
    }
  }
}

resource "proxmox_virtual_environment_pool" "this" {
  pool_id = "${var.app_name}-pool"
  comment = "[terraform][${var.app_name}] isolation pool"
}

module "network" {
  source = "./modules/network"

  app_name     = var.app_name
  vlan_id      = var.vlan_id
  bridge       = var.bridge
  proxmox_node = var.proxmox_node
}

module "token" {
  source = "./modules/token"

  app_name   = var.app_name
  pool_id    = proxmox_virtual_environment_pool.this.pool_id
  sdn_zone   = module.network.zone_id
  storage_id = var.storage_id
}
