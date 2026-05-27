# Example: uncomment and fill in to create a container
module "pihole" {
  source = "../../modules/compute/proxmox"

  app_name           = "pihole"
  instance_size      = "small"
  disk_size          = 8
  ip_address         = "172.16.10.100/24"
  gateway            = "172.16.10.1"
  proxmox_node       = "pve"
}
