module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.3"
  # Autoscaling group
  name                      = "example-asg"
  min_size                  = 3
  max_size                  = 10
  desired_capacity          = 3
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true
  image_id                    = "ami-0b0dcb5067f052a63"
  instance_type               = "t3.micro"
  ebs_optimized               = false
  enable_monitoring           = false
  user_data                   = "IyEvYmluL2Jhc2gKc3VkbyB5dW0gaW5zdGFsbCBodHRwZCAteSAKc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQg"
  target_group_arns           = module.alb.target_group_arns
  security_groups = [
    aws_security_group.allow_tls.id
  ]
}


resource "aws_security_group" "allow_tls" {
  name        = "terraform-testing-alb"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}





module "alb" {
  source             = "terraform-aws-modules/alb/aws"
  version            = "~> 8.0"
  name               = "my-alb"
  load_balancer_type = "application"
  enable_cross_zone_load_balancing = true
  vpc_id             = var.vpc_id
  subnets = [
    var.public_subnet1,
    var.public_subnet2,
    var.public_subnet3
  ]
  security_groups = [
    aws_security_group.allow_tls.id
  ]

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}



resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "web.${var.domain}"
  type    = "CNAME"
  ttl     = 300
  records = [module.alb.lb_dns_name]
}

variable "zone_id" {}
variable "domain" {}
variable "vpc_id" {}
variable "public_subnet1" {}
variable "public_subnet2" {}
variable "public_subnet3" {}
