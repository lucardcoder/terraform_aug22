variable "region" {
  type        = string
  description = "Please provide region information"
  default     = ""
}

variable "name" {
  type        = string
  description = "Please provide name information"
  default     = ""
}


variable "cidr" {
  type        = string
  description = "Please provide cidr information"
  default     = ""
}


variable "public_subnets" {
  type        = list(any)
  description = "Please provide cidr information"
  default     = []
}


variable "private_subnets" {
  type        = list(any)
  description = "Please provide cidr information"
  default     = []
}


variable "tags" {
  type        = map(any)
  description = "Please provide tag information"
  default     = {}
}