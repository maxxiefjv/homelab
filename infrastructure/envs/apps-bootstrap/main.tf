terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.107.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = var.proxmox_insecure

  ssh {
    agent    = true
    username = var.proxmox_ssh_username
  }
}

resource "proxmox_virtual_environment_role" "app_env_role" {
  role_id = "AppEnvRole"
  privileges = [
    "VM.Allocate",
    "VM.Audit",
    "VM.Clone",
    "VM.Config.HWType",
    "VM.Config.CPU",
    "VM.Config.Memory",
    "VM.Config.Network",
    "VM.Config.Disk",
    "VM.Config.CDROM",
    "VM.Config.Options",
    "VM.Config.Cloudinit",
    "VM.PowerMgmt",
    "Datastore.AllocateSpace",
    "Datastore.Audit",
    "Datastore.Allocate",
    "SDN.Use",
    "Sys.Audit",
  ]
}

resource "proxmox_acl" "terraform_apps_user" {
  path      = "/"
  role_id   = proxmox_virtual_environment_role.app_env_role.role_id
  user_id   = "terraform-apps@pam"
  propagate = true
}

module "oktobus" {
  source = "../../modules/bootstrap/proxmox"

  app_name            = "oktobus"
  vlan_id             = 210
  bridge              = var.bridge
  proxmox_node        = var.proxmox_node
  storage_id          = var.storage_id
  snippets_storage_id = "snippets"
  template_vm_id      = var.template_vm_id

  depends_on = [proxmox_virtual_environment_role.app_env_role]
}

module "app_2" {
  source = "../../modules/bootstrap/proxmox"

  app_name            = "app-2"
  vlan_id             = 220
  bridge              = var.bridge
  proxmox_node        = var.proxmox_node
  storage_id          = var.storage_id
  snippets_storage_id = "snippets"
  template_vm_id      = var.template_vm_id

  depends_on = [proxmox_virtual_environment_role.app_env_role]
}
