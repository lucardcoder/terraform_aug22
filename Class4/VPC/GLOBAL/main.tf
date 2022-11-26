provider "google" {
	region = var.vpc_config["region"]
	zone = var.vpc_config["zone"]
}

resource "google_compute_network" "vpc" {
	name = "vpc"
	auto_create_subnetworks = "true"
	routing_mode = "GLOBAL"
}

variable "vpc_config" {
	type = map(any)
	default = {
		vpc_name = "vpc"
		region = "us-central1"
		zone = "us-central1-c"
		subnet1_cidr = "10.0.1.0/24"
		subnet2_cidr = "10.0.2.0/24"
		subnet3_cidr = "10.0.3.0/24"
	}
}
