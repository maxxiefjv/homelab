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
