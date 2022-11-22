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
  availability_zones =	[
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
}