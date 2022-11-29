dev:
		terraform init && terraform workspace new dev || terraform workspace select dev && terraform apply -var-file dev.tfvars -auto-approve 

qa:
		terraform init &&  terraform workspace new qa || terraform workspace select qa && terraform apply -var-file qa.tfvars -auto-approve 

prod:
		terraform init &&  terraform workspace new prod || terraform workspace select prod && terraform apply -var-file prod.tfvars -auto-approve 

destroy_dev:
		terraform workspace select dev && terraform destroy -var-file dev.tfvars -auto-approve 

destroy_qa:
		terraform workspace select qa && terraform destroy -var-file qa.tfvars -auto-approve 

destroy_prod:
		terraform workspace select prod && terraform destroy -var-file prod.tfvars -auto-approve 