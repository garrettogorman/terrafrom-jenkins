##################################################################################
# VARIABLES
##################################################################################

# variable "aws_access_key" {}
# variable "aws_secret_key" {}

variable "projectcode" {
  default = "8675309"
}

# variable "url" {}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "public_subnet_count" {
  default = "2"
}

variable "private_subnet_count" {
  default = "2"
}
