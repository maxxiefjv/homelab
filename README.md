# private-infra

Terraform for private Proxmox infrastructure. Manages home services and per-app isolation primitives.

## Architecture

This repo (private-infra) owns the Proxmox side. App teams work in a separate repo (shared-infra) using scoped tokens produced here. Isolation is enforced at the Proxmox API level via token scoping — not convention.

## Layout

```
envs/apps-bootstrap/   run once with admin token — creates roles, pools, VNETs, scoped tokens
envs/home/             home services (pihole, etc.)
modules/compute/proxmox/           LXC container module
modules/bootstrap/proxmox/         per-environment isolation module
modules/bootstrap/proxmox/modules/ network, token sub-modules
```

## Bootstrap

### Prerequisites (must exist in Proxmox before running)

The following must be created manually before running bootstrap:

- **`terraform-apps@pam` user** — service account that tokens are issued under:
  ```bash
  pveum useradd terraform-apps@pam --comment "[terraform] service account for app environment tokens"
  ```
- **Admin token with sufficient privileges** — the token in `local.tfvars` needs permission to create roles, pools, SDN zones/VNETs, and ACLs. Grant it:
  ```bash
  pveum aclmod / --tokens '<your-token>' --roles Administrator
  ```
- **SDN zone uplink bridge** — the bridge specified by `bridge` in `local.tfvars` (e.g. `vmbr0`) must exist on the node.
- **Storage** — the storage specified by `storage_id` in `local.tfvars` (e.g. `local-lvm`) must exist.

### Run bootstrap

```bash
cd envs/apps-bootstrap
terraform init
terraform apply -var-file=../../local.tfvars
```

### Retrieve a scoped token for an app team

```bash
terraform output -raw oktobus_token
```

The app team puts this value in their `local.tfvars` as `proxmox_api_token = "terraform-apps@pam!oktobus=<secret>"` and runs Terraform against their shared-infra environment.

## Adding a new app environment

Add one module block in `envs/apps-bootstrap/main.tf`:

```hcl
module "my_app" {
  source = "../../modules/bootstrap/proxmox"

  app_name     = "my-app"
  vlan_id      = 230
  sdn_zone     = proxmox_sdn_zone_vlan.apps.id
  proxmox_node = var.proxmox_node
  storage_id   = var.storage_id

  depends_on = [
    proxmox_virtual_environment_role.app_env_role,
    proxmox_sdn_zone_vlan.apps,
  ]
}
```

Add matching outputs in `envs/apps-bootstrap/outputs.tf`, then `terraform apply`.

## Adding a new home service

Add a module block in `envs/home/main.tf` and run `terraform apply -var-file=../../local.tfvars` from that directory.

## Security

- Tokens use `privileges_separation = true` — effective permissions are the intersection of the user's permissions and the token's ACLs. The token can never exceed its explicit grants even if the user gains broader access.
- ACLs are bound to `/pool/<app>-pool`, `/sdn/vnets/<vnet-id>`, and `/storage/<id>` only. Proxmox rejects requests to any other path before Terraform even evaluates them.
- `AppEnvRole` is created once in bootstrap and shared across all environments.
- `terraform-apps@pam` is a PVE-realm user with no password — it can only authenticate via API tokens, never interactively.
