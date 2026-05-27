terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.107"
    }
  }
}

locals {
  size_map = {
    small  = { cores = 1, memory = 512 }
    medium = { cores = 2, memory = 1024 }
    large  = { cores = 4, memory = 2048 }
  }
  size = local.size_map[var.instance_size]
  tags = concat(["terraform", var.app_name], var.tags)
}

resource "proxmox_virtual_environment_container" "this" {
  node_name = var.proxmox_node
  tags      = local.tags

  lifecycle {
    prevent_destroy = true
  }

  clone {
    node_name = var.proxmox_node
    vm_id     = data.proxmox_virtual_environment_containers.template.containers[0].vm_id
  }

  cpu {
    cores = local.size.cores
  }

  memory {
    dedicated = local.size.memory
  }

  disk {
    datastore_id = "local-lvm"
    size         = var.disk_size
  }

  network_interface {
    name     = "eth0"
    bridge   = "vmbr0"
  }

  initialization {
    hostname = var.app_name

    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }

  }
}

data "proxmox_virtual_environment_containers" "template" {
  node_name = var.proxmox_node
  tags      = ["base-template"]

  filter {
    name   = "template"
    values = [true]
  }
}
