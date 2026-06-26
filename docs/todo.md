# TODO

## Documentation
- [ ] Write about the app/sandbox environment

## Applications
- [ ] Setup vault for passwords (e.g., bitwarden)

## Networking
- [ ] Backups for networking device configs
- [ ] Set up dev/sandbox VLAN (planned but not done)
- [ ] Add IDS/IPS system (Suricata, Security Onion). Just on the firewall side as it's a small network (North-South monitoring).
- [ ] Decide on monitoring placement, likely small ELK stack for XLC containers

## Infrastructure
- [ ] Set up backups (VMs and LXC containers)
- [ ] Set up auto-update cronjob for LXC containers
- [ ] Set up system monitoring using prometheus (alerting) & grafana

## Hardware
- [ ] Add dedicated storage device
- [ ] Add dedicated GPU / LLM machine
