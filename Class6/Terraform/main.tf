data "aws_ami" "packer" {
  filter {
    name   = "name"
    values = ["packer1"]
  }
  owners = ["self"]
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.packer.id
  instance_type = "t2.micro"
}
