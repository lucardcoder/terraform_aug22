### aug_devops_2022_terraform
#
##
##
###
### Instructions
#### Step1. Create tfvars file in envs/regions/REGION/REGION.tfvars
#### Step2. Add content 
```
region = "eu-west-2"
name = "my-vpc"
cidr = "10.0.0.0/16"  
private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
tags = {
    Terraform   = "true"
    Environment = "dev"
}
```

#### Step3. Update Makefile accordingly 
#### Step4. make  build-REGION