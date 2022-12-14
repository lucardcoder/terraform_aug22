
data "aws_availability_zones" "all" {}

resource "aws_default_subnet" "default_az1" {
        availability_zone = data.aws_availability_zones.all.names[0]
}

resource "aws_default_subnet" "default_az2" {
        availability_zone = data.aws_availability_zones.all.names[1]
}

resource "aws_default_subnet" "default_az3" {
        availability_zone = data.aws_availability_zones.all.names[2]
}


data "aws_eks_cluster" "cluster" {
        name = module.my-cluster.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
        name = module.my-cluster.cluster_id
}
provider "kubernetes" {
        host = data.aws_eks_cluster.cluster.endpoint
        cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
        token = data.aws_eks_cluster_auth.cluster.token
}
module "my-cluster" {
        source = "terraform-aws-modules/eks/aws"
        version = "12.0.0"
        cluster_name = var.cluster_name
        cluster_version = var.cluster_version
        subnets = [
                aws_default_subnet.default_az1.id,
                aws_default_subnet.default_az2.id,
                aws_default_subnet.default_az3.id,
        ]
        vpc_id = aws_default_subnet.default_az3.vpc_id
        cluster_create_security_group = true
        worker_groups = [{
        instance_type = var.instance_type
        asg_max_size = var.asg_max_size
        asg_min_size = var.asg_min_size #min size should be 1
                }
        ]
        tags = var.tags
}


