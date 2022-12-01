packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "region" {
  type    = string
  default = "us-east-2"
}

source "amazon-ebs" "amazon_linux" {
  region        = "${var.region}"
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"
  ami_name      = "packer_{{timestamp}}"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-ebs"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
}

build {
  sources = ["source.amazon-ebs.amazon_linux"]

  provisioner "ansible" {
    playbook_file = "./httpd.yml"
  }
}
