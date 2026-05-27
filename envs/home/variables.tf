variable "proxmox_endpoint" {
  type        = string
  description = "Proxmox API URL, e.g. https://172.16.1.10:8006"
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  description = "API token in the format: user@realm!token-id=secret"
}

variable "proxmox_insecure" {
  type    = bool
  default = true
}

variable "proxmox_ssh_username" {
  type    = string
  default = "root"
}
