# private-ansible

Ansible configuration for private infrastructure running on Proxmox. Handles everything inside containers and VMs after Terraform provisions them — base configuration, service installation, patching, and lifecycle management.

Terraform provisioning lives in `private-infra`.

## Prerequisites

- Ansible installed
- SSH key at `~/.ssh/ansible_ed25519` for the `ansible` user
- Vault password file at `.vault_pass` (gitignored)
- `community.general` collection: `ansible-galaxy collection install community.general`

## Vault setup

Secrets live in `inventory/group_vars/all/vault.yml`. It must be encrypted before committing:

```bash
# First time: fill in the placeholder values, then encrypt
ansible-vault encrypt inventory/group_vars/all/vault.yml

# Edit after encryption
ansible-vault edit inventory/group_vars/all/vault.yml
```

Create `.vault_pass` with your vault password (one line, no newline required):

```bash
echo 'your-vault-password' > .vault_pass
chmod 600 .vault_pass
```

## Inventory

Update `inventory/hosts.ini` with real IPs and `proxmox_vmid` values before running any playbooks.

## Make targets

| Target | What it does |
|---|---|
| `make converge` | Full converge — applies base to all hosts, then all service roles |
| `make upgrade` | Snapshot all hosts, run `apt dist-upgrade`, reboot if needed, update Pi-hole |
| `make snapshot` | Take pre-upgrade Proxmox snapshots for all hosts |
| `make install-pihole` | Converge the home_services group (base + Pi-hole install) |
| `make update-pihole` | Run `pihole -up` and `pihole -g` on home_services hosts |
| `make stop-pihole` | Stop and disable pihole-FTL on home_services hosts |

## Adding a new service

Follow the Pi-hole role as a pattern:

1. Create `roles/<service>/tasks/main.yml` — delegates to `install.yml` by default via `pihole_tasks` variable pattern
2. Create `roles/<service>/tasks/install.yml`, `update.yml`, `shutdown.yml`
3. Add the host to `inventory/hosts.ini` in the appropriate group
4. Add a `playbooks/<group>.yml` or extend an existing one
5. Add Makefile targets mirroring the Pi-hole ones

## Role structure

- **base** — applied to every host: openssh-server, sudo, ansible user/sudoers, locale
- **pihole** — Pi-hole DNS ad-blocker; install is idempotent (skips if binary exists)
