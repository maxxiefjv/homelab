variable "proxmox_endpoint" {
  type        = string
  description = "Proxmox API URL, e.g. https://172.16.1.10:8006"
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  description = "Admin API token in the format: user@realm!token-id=secret"
}

variable "proxmox_insecure" {
  type    = bool
  default = true
}

variable "proxmox_ssh_username" {
  type    = string
  default = "root"
}

variable "proxmox_node" {
  type        = string
  description = "Proxmox node name"
}

variable "bridge" {
  type        = string
  description = "Network bridge used as the uplink for the VLAN SDN zone (e.g. vmbr0)"
}

variable "storage_id" {
  type        = string
  description = "Proxmox storage ID to scope app tokens to (e.g. local-lvm)"
}

variable "template_vm_id" {
  type        = number
  description = "VM ID of the base template all apps clone from (e.g. 9001)"
}
