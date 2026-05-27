variable "app_name" {
  type        = string
  description = "Name of the environment, e.g. oktobus"
}

variable "vlan_id" {
  type        = number
  description = "VLAN tag for this environment's VNET"
}

variable "bridge" {
  type        = string
  description = "Network bridge used as the uplink for the per-app VLAN zone (e.g. vmbr0)"
}

variable "proxmox_node" {
  type        = string
  description = "Proxmox node name"
}

variable "storage_id" {
  type        = string
  description = "Proxmox storage ID to scope the token to (e.g. local-lvm)"
}
