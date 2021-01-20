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

# ALB用のセキュリティグループ
module "alb_sg" {
  source = "../../elements/security_group/"

  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id
  name        = "alb-sg-${var.pj_prefix}"
  description = "Security group for LoadBalancer of dev"
  pj_prefix   = var.pj_prefix
}
module "alb_sg_ingress_rule" {
  source = "../../elements/security_group_rule/"

  for_each                 = var.alb_sg_ingress_rules
  security_group_id        = module.alb_sg.id
  type                     = "ingress"
  protocol                 = each.value["protocol"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
  description              = each.value["description"]
}
module "alb_sg_egress_rule" {
  source = "../../elements/security_group_rule/"

  for_each                 = var.alb_sg_egress_rules
  security_group_id        = module.alb_sg.id
  type                     = "egress"
  protocol                 = each.value["protocol"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
  description              = each.value["description"]
}

# ALB作成
module "alb" {
  source = "../../elements/lb/"

  name                       = "alb-${var.pj_prefix}"
  pj_prefix                  = var.pj_prefix
  load_balancer_type         = "application"
  internal                   = false
  security_groups            = [module.alb_sg.id]
  subnets                    = data.terraform_remote_state.network.outputs.public_subnet_ids
  enable_deletion_protection = false
  enable_http2               = true
}
