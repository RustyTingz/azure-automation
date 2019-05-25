ANSIBLE_CLI_PARAMETERS = -vvvv

PLATFORM_ATTRIBUTES_FILE = src/attributes.yml
TERRAFORM_FOLDER = terraform/

init:
	pipenv install

build:
	pipenv run ansible-playbook  -e @$(PLATFORM_ATTRIBUTES_FILE) ./ansible/playbook-bootstrapper.yml $(ANSIBLE_CLI_PARAMETERS)

plan:
	terraform init -reconfigure $(TERRAFORM_FOLDER)
	terraform plan -out=$(TERRAFORM_FOLDER)terraform-plan $(TERRAFORM_FOLDER)

deploy:
	terraform apply -auto-approve $(TERRAFORM_FOLDER)terraform-plan


test-playbooks-syntax:
	for play in `ls ./ansible/playbook-*`;	\
	do \
		pipenv run ansible-playbook $$play --syntax-check;	\
	done;

test:
	inspec exec inspec/azure-infrastructure --attrs $(PLATFORM_ATTRIBUTES_FILE) -t azure://

destroy:
	terraform destroy -auto-approve $(TERRAFORM_FOLDER)
	pipenv run ansible-playbook  -e @$(PLATFORM_ATTRIBUTES_FILE) ./ansible/playbook-teardown.yml --extra-vars "state=absent" $(ANSIBLE_CLI_PARAMETERS)