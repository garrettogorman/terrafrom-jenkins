##################################################################################
# BACKENDS
##################################################################################
terraform {
  backend "s3" {
    key            = "networking.state"
    region         = "eu-west-1"
    dynamodb_table = "gar-ddt-tfstatelock"
  }
}
