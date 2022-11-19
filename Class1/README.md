terraform init  
  initialize current folder 

terraform validate 
    validates the code 

terraform  plan 
  shows what would happen when "apply" run 

terraform apply 
terraform apply --auto-approve
  creates/changes/destroys


terraform apply -target NAME
  creates 1 resource out of all


terraform destroy 
terraform destroy --auto-approve
  destroys




terraform state list
terraform destroy   -target  NAME 
  destroys one resources out of all



terraform show 
  shows list of resources  + arguments + attributes

terraform state list 
  shows list of resource names

terraform import aws_iam_user.important_user  important_user
  imports user