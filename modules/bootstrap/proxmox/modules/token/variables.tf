variable "app_name" {
  type = string
}

variable "pool_id" {
  type        = string
  description = "Resource pool ID to scope the token to"
}

variable "sdn_zone" {
  type        = string
  description = "SDN zone ID to grant SDN.Use on — Proxmox does not support per-VNET ACL paths"
}

variable "storage_id" {
  type        = string
  description = "Proxmox storage ID to scope the token to"
}

variable "snippets_storage_id" {
  type        = string
  description = "Proxmox storage ID that holds snippets (cloud-init, etc.)"
  default     = "local"
}

variable "proxmox_node" {
  type        = string
  description = "Proxmox node name — VM.Allocate must be granted at the node level for VM creation"
}

variable "template_vm_id" {
  type        = number
  description = "VM ID of the template to clone from — token needs explicit VM.Clone on this path since templates are not in the app pool"
}
