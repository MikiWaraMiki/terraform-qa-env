# config.tfvarsから読み取る
variable "region" {
  default = ""
}
variable "profile" {
  default = ""
}

variable "pj_prefix" {
  default = "sample-qa-create"
}
/*
  ../backend-config.ymlを読み込む
*/
locals {
  backend_config = yamldecode(file("../backend-config.yml"))
}

variable "alb_sg_ingress_rules" {
  default = {
    1 : {
      from_port   = 80,
      to_port     = 80,
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"],
      description = "allow http from any"
    },
    2 : {
      from_port   = 443,
      to_port     = 443,
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"],
      description = "allow https from any"
    }
  }
}

variable "alb_sg_egress_rules" {
  default = {
    1 : {
      from_port   = 0,
      to_port     = 0,
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "allow all"
    }
  }
}
