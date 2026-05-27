variable "app_name" {
  type = string
}

variable "instance_size" {
  type = string
  validation {
    condition     = contains(["small", "medium", "large"], var.instance_size)
    error_message = "instance_size must be small, medium, or large."
  }
}

variable "disk_size" {
  type = number
}

variable "ip_address" {
  type = string
}

variable "gateway" {
  type = string
}

variable "proxmox_node" {
  type = string
}

variable "tags" {
  type = list(string)
  default = []
}
