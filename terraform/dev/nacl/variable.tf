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

/*
 NACLのルールを追加する場合はここに記載する
 See. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule
 format
 {
   1: {
     rule_number = 1,
     protocol = "tcp",
     cidr_block = "0.0.0.0/0"
   }
 }
*/
## public subnet用
# egress white list
variable "egress_white_list_rules_for_public" {
  default = null
}
# egress black list
variable "egress_black_list_rules_for_public" {
  default = null
}
# igress white list
variable "ingress_white_list_rules_for_public" {
  default = null
}
variable "ingress_black_list_rules_for_public" {
  default = null
}
## private subnet用
# egress white list
variable "egress_white_list_rules_for_private" {
  default = null
}
# egress black list
variable "egress_black_list_rules_for_private" {
  default = null
}
# igress white list
variable "ingress_white_list_rules_for_private" {
  default = null
}
variable "ingress_black_list_rules_for_private" {
  default = null
}
