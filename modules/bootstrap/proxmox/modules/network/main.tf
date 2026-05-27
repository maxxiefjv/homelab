terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.107.0"
    }
  }
}

locals {
  zone_id = substr(replace(var.app_name, "-", ""), 0, 8)
}

resource "proxmox_sdn_zone_vlan" "this" {
  id     = local.zone_id
  bridge = var.bridge
  nodes  = [var.proxmox_node]
}

resource "proxmox_sdn_vnet" "this" {
  id   = local.zone_id
  zone = proxmox_sdn_zone_vlan.this.id
  tag  = var.vlan_id
}
