provider "aws" {
    region = "us-east-1"
}


resource "aws_security_group" "allow_tls" {
  name        = "test-sec-group"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.terraform_remote_state.main.outputs.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "test-sec-group"
  }
}

output security_group_id { 
    value = aws_security_group.allow_tls.id
}