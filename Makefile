INVENTORY ?= inventory/lab.ini
MANIFEST  ?= manifests/acme.lab.yml
SECRETS   ?= secrets/acme.lab.yml

EXTRA_VARS = -e @$(MANIFEST) -e @$(SECRETS)

.PHONY: check site bootstrap platform apps verify

check:
	ansible-playbook -i $(INVENTORY) playbooks/site.yml $(EXTRA_VARS) --check --diff

bootstrap:
	ansible-playbook -i $(INVENTORY) playbooks/bootstrap.yml $(EXTRA_VARS)

platform:
	ansible-playbook -i $(INVENTORY) playbooks/platform.yml $(EXTRA_VARS)

apps:
	ansible-playbook -i $(INVENTORY) playbooks/apps.yml $(EXTRA_VARS)

verify:
	ansible-playbook -i $(INVENTORY) playbooks/verify.yml $(EXTRA_VARS)

site:
	ansible-playbook -i $(INVENTORY) playbooks/site.yml $(EXTRA_VARS)
