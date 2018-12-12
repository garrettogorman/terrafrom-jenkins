##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  # access_key = "${var.aws_access_key}"
  # secret_key = "${var.aws_secret_key}"
  region     = "eu-west-1"
}

##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"
#   name   = "ddt-${terraform.workspace}"

#   # cidr            = "${data.external.configuration.result.vpc_cidr_range}"
#   cidr            = "${var.vpc_cidr_range}"
#   azs             = "${slice(data.aws_availability_zones.available.names,0,data.external.configuration.result.vpc_subnet_count)}"
#   private_subnets = "${data.template_file.private_cidrsubnet.*.rendered}"
#   public_subnets  = "${data.template_file.public_cidrsubnet.*.rendered}"

#   enable_nat_gateway = true

#   create_database_subnet_group = false

#   # tags = "${local.common_tags}"
# }


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = "jenkins-${terraform.workspace}"
  cidr            = "${var.vpc_cidr}"
  azs             = ["${data.aws_availability_zones.available.names}"]
  private_subnets = "${data.template_file.private_cidrsubnet.*.rendered}"
  public_subnets  = "${data.template_file.public_cidrsubnet.*.rendered}"

  # enable_nat_gateway           = false
  create_database_subnet_group = false

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  tags = {
    Environment = "${terraform.workspace}"
  }
}

