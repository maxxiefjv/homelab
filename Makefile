INVENTORY        := inventory/hosts.ini
VAULT_PASS_FILE  := .vault_pass
ANSIBLE_OPTS     := -i $(INVENTORY) --vault-password-file $(VAULT_PASS_FILE)

.PHONY: converge upgrade snapshot install-pihole update-pihole stop-pihole uninstall-pihole

converge:
	ansible-playbook $(ANSIBLE_OPTS) playbooks/site.yml

upgrade:
	ansible-playbook $(ANSIBLE_OPTS) playbooks/upgrade.yml

snapshot:
	ansible-playbook $(ANSIBLE_OPTS) playbooks/snapshot.yml

install-pihole:
	ansible-playbook $(ANSIBLE_OPTS) playbooks/home_services.yml

update-pihole:
	ansible-playbook $(ANSIBLE_OPTS) -e pihole_tasks=update playbooks/home_services.yml

stop-pihole:
	ansible-playbook $(ANSIBLE_OPTS) -e pihole_tasks=shutdown playbooks/home_services.yml

uninstall-pihole:
	ansible-playbook $(ANSIBLE_OPTS) -e pihole_tasks=uninstall playbooks/home_services.yml
