PWD := $(shell pwd)
export ANSIBLE_ROLES_PATH=${PWD}/roles

install:
	ansible-playbook -i inventory.ini playbooks/install.yaml

upgrade:
	ansible-playbook -i inventory.ini playbooks/upgrade.yaml -v
