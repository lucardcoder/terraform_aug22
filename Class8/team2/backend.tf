terraform {
  required_version = "1.1.1"
  backend "s3" {
    bucket         = "terraform-backend-class-farrukh"
    key            = "project/team2/asg/tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform"
    encrypt        = true
  }
}


#  aws   s3  mb  s3://terraform-backend-class-farrukh   --region   us-east-1 