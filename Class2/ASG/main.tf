module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "6.5.3"
  # Autoscaling group
  name = "example-asg"
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
  image_id          = "ami-0b0dcb5067f052a63"
  instance_type     = "t3.micro"
  ebs_optimized     = false
  enable_monitoring = false
  user_data         = "IyEvYmluL2Jhc2gKc3VkbyB5dW0gaW5zdGFsbCBodHRwZCAteSAKc3VkbyBzeXN0ZW1jdGwgc3RhcnQgaHR0cGQg"
}


# module "alb" {
#   source  = "terraform-aws-modules/alb/aws"
#   version = "~> 8.0"
#   name = "my-alb"
#   load_balancer_type = "application"
#   vpc_id             = "vpc-abcde012"
#   subnets            = ["subnet-abcde012", "subnet-bcde012a"]
#   security_groups    = ["sg-edcd9784", "sg-edcd9785"]

#   access_logs = {
#     bucket = "my-alb-logs"
#   }

#   target_groups = [
#     {
#       name_prefix      = "pref-"
#       backend_protocol = "HTTP"
#       backend_port     = 80
#       target_type      = "instance"
#       targets = {
#         my_target = {
#           target_id = "i-0123456789abcdefg"
#           port = 80
#         }
#         my_other_target = {
#           target_id = "i-a1b2c3d4e5f6g7h8i"
#           port = 8080
#         }
#       }
#     }
#   ]

#   http_tcp_listeners = [
#     {
#       port               = 80
#       protocol           = "HTTP"
#       target_group_index = 0
#     }
#   ]

# }



resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "web.${var.domain}"
  type    = "A"
  ttl     = 300
  records = ["127.0.0.1"]
}

variable zone_id {}
variable domain {}