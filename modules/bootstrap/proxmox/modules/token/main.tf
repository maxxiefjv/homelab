terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.107.0"
    }
  }
}

resource "proxmox_user_token" "this" {
  user_id               = "terraform-apps@pam"
  token_name            = var.app_name
  privileges_separation = true
  comment               = "[terraform][${var.app_name}] scoped API token"
}

resource "proxmox_acl" "node" {
  path      = "/nodes/${var.proxmox_node}"
  role_id   = "AppEnvRole"
  token_id  = proxmox_user_token.this.id
  propagate = true
}

resource "proxmox_acl" "pool" {
  path      = "/pool/${var.pool_id}"
  role_id   = "AppEnvRole"
  token_id  = proxmox_user_token.this.id
  propagate = true
}

resource "proxmox_acl" "sdn" {
  path      = "/sdn/zones/${var.sdn_zone}"
  role_id   = "AppEnvRole"
  token_id  = proxmox_user_token.this.id
  propagate = true
}

resource "proxmox_acl" "storage" {
  path      = "/storage/${var.storage_id}"
  role_id   = "AppEnvRole"
  token_id  = proxmox_user_token.this.id
  propagate = true
}

resource "proxmox_acl" "snippets_storage" {
  path      = "/storage/${var.snippets_storage_id}"
  role_id   = "AppEnvRole"
  token_id  = proxmox_user_token.this.id
  propagate = true
}

resource "proxmox_acl" "template" {
  path      = "/vms/${var.template_vm_id}"
  role_id   = "AppEnvRole"
  token_id  = proxmox_user_token.this.id
  propagate = false
}
