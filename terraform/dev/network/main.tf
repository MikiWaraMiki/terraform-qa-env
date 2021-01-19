terraform {
  required_version = ">=0.13.0"
  backend "s3" {}
}
provider "aws" {
  region  = var.region
  profile = var.profile
}
# usecase/network/main.tfを呼び出して、
# ベースとなるNWを作成する
module "network" {
  source                    = "../../usecase/network/"
  pj_prefix                 = var.pj_prefix
  vpc_cidr_block            = var.vpc_cidr_block
  enable_dns_support        = var.enable_dns_support
  enable_dns_hostnames      = var.enable_dns_hostnames
  instance_tenancy          = "default"
  public_subnet_parameters  = var.public_subnet_parameters
  private_subnet_parameters = var.private_subnet_parameters
  natgw_counts              = var.natgw_counts
}
