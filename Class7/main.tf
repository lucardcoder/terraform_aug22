data "aws_availability_zones" "all" {}

output "AZ" {
	value = data.aws_availability_zones.all.names
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

output ami_id {
  value = data.aws_ami.ubuntu.id
}


module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = var.name
  cidr               = var.cidr
  azs                = [
    data.aws_availability_zones.all.names[0],
    data.aws_availability_zones.all.names[1],
    data.aws_availability_zones.all.names[2],
  ]
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = false
  enable_vpn_gateway = false
  tags               = var.tags
}
