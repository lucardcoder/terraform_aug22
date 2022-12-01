packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "amazon_linux" {
  region        = "us-east-1"
  source_ami    = "ami-fce3c696"
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"
  ami_name      = "packer1"
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
