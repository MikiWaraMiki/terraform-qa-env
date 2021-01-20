variable "vpc_id" {
  description = "VPC ID of nacl"
  type        = string
}
variable "nacl_name" {
  description = "ACL Name"
  type        = string
}
variable "association_subnet_ids" {
  description = "SubnetIds of nacl"
  type        = list(string)
}
variable "pj_prefix" {
  description = "Project Prefix"
  type        = string
}
/**
 ruleは以下のようなフォーマットでくる想定
 {
   1: {
     rule_number = 1,
     protocol = "tcp",
     cidr_block = "0.0.0.0/0"
   }
 }
**/
variable "egress_white_list_rules" {
  description = "nacl white list rules for egress"
  type        = map(map(any))
  default     = null
}
variable "egress_black_list_rules" {
  description = "nacl black list rules for egress"
  type        = map(map(any))
  default     = null
}
variable "ingress_white_list_rules" {
  description = "nacl white list rules for ingress"
  type        = map(map(any))
  default     = null
}
variable "ingress_black_list_rules" {
  description = "nacl black list rules for ingress"
  type        = map(map(any))
  default     = null
}
