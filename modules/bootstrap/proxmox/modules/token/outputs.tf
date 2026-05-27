output "scoped_token" {
  value     = proxmox_user_token.this.value
  sensitive = true
}

output "token_id" {
  value = proxmox_user_token.this.id
}
