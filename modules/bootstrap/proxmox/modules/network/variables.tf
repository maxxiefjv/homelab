variable "app_name" {
  type = string
}

variable "vlan_id" {
  type        = number
  description = "VLAN tag for this environment's VNET"
}

variable "bridge" {
  type        = string
  description = "Network bridge used as the uplink for the VLAN zone (e.g. vmbr0)"
}

variable "proxmox_node" {
  type        = string
  description = "Proxmox node name"
}
