terraform {
  required_version = ">=0.13.0"
  backend "s3" {}
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

/*
  networkフォルダで作成したvpc_idとsubnet_idを取得する
*/
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket  = local.backend_config.bucket
    key     = "${local.backend_config.key_base}/network.tfstate"
    region  = local.backend_config.region
    profile = local.backend_config.profile
  }
}

module "nacl_for_public" {
  source = "../../elements/nacl/"

  vpc_id                 = data.terraform_remote_state.network.outputs.vpc_id
  association_subnet_ids = data.terraform_remote_state.network.outputs.public_subnet_ids
  nacl_name              = "nacl-for-public-${var.pj_prefix}"
  pj_prefix              = var.pj_prefix
}

module "nacl_for_private" {
  source = "../../elements/nacl/"

  vpc_id                 = data.terraform_remote_state.network.outputs.vpc_id
  association_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  nacl_name              = "nacl-for-private-${var.pj_prefix}"
  pj_prefix              = var.pj_prefix
}
