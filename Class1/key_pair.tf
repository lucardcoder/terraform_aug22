resource "aws_key_pair" "bastion-host" {
  key_name   = "bastion-host-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_key_pair" "bastion-host2" {
  key_name   = "bastion-host-ke2y"
  public_key = file("~/.ssh/id_rsa.pub")
}