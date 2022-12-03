gp:
		git pull

init: gp
		terraform init 

validate: init
		terraform validate

build-virginia: validate
		terraform workspace  new virginia  ||  terraform workspace  select virginia && terraform apply -var-file envs/regions/us-east-1/us-east-1.tfvars  -auto-approve

build-london: validate
		terraform workspace  new london  ||  terraform workspace  select london && terraform apply -var-file envs/regions/eu-west-2/eu-west-2.tfvars  -auto-approve

build-ohio: init
		terraform workspace  new ohio  ||  terraform workspace  select ohio     &&  terraform apply -var-file envs/regions/us-east-2/us-east-2.tfvars -auto-approve

destroy-ohio:
		terraform workspace  select ohio   && terraform destroy -var-file envs/regions/us-east-2/us-east-2.tfvars

destroy-virginia:
		terraform workspace  select virginia   && terraform destroy -var-file envs/regions/us-east-1/us-east-1.tfvars

destroy-london:
		terraform workspace  select london   && terraform destroy -var-file envs/regions/eu-west-2/eu-west-2.tfvars


build-all: 
		make build-virginia && make build-ohio



# make build-ohio