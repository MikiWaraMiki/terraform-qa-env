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
