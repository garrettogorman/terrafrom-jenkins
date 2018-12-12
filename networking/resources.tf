##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  region     = "eu-west-1"
}

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {}

##################################################################################
# RESOURCES
##################################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = "jenkins-${terraform.workspace}"
  cidr            = "${var.vpc_cidr}"
  azs             = ["${data.aws_availability_zones.available.names}"]
  private_subnets = "${data.template_file.private_cidrsubnet.*.rendered}"
  public_subnets  = "${data.template_file.public_cidrsubnet.*.rendered}"

  create_database_subnet_group = false

  enable_nat_gateway     = false
  one_nat_gateway_per_az = false

  tags = {
    Environment = "test-${terraform.workspace}"
  }
}

