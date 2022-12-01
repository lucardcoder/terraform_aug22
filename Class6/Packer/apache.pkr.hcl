packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_id" {
  type    = string
  default = "ami-0beaa649c482330f7"
}

variable "region" {
  type    = string
  default = "us-east-2"
}

source "amazon-ebs" "amazon_linux" {
  region        = "${var.region}"
  source_ami    = "${var.ami_id}"
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"
  ami_name      = "packer_{{timestamp}}"
}

build {
  sources = ["source.amazon-ebs.amazon_linux"]

  provisioner "shell" {
    inline = [
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }
}
