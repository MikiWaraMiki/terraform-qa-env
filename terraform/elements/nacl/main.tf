# Create network acl
resource "aws_network_acl" "acl" {
  vpc_id     = var.vpc_id
  subnet_ids = var.association_subnet_ids
  tags = {
    "Name"     = var.nacl_name
    "PJPrefix" = var.pj_prefix
  }
}
locals {
  # aclは指定がなければコンソールで作成した際と同じデフォルトルールを作成する
  egress_white_list_rules = var.egress_white_list_rules != null ? var.egress_white_list_rules : {
    1 : {
      rule_number = 100,
      egress      = true,
      protocol    = -1,
      cidr_block  = "0.0.0.0/0"
    }
  }
  egress_black_list_rules = var.egress_black_list_rules != null ? var.egress_black_list_rules : {}

  ingress_white_list_rules = var.ingress_white_list_rules != null ? var.ingress_white_list_rules : {
    1 : {
      rule_number = 100,
      egress      = false,
      protocol    = -1,
      rule_action = "allow"
      cidr_block  = "0.0.0.0/0"
    }
  }
  ingress_black_list_rules = var.ingress_black_list_rules != null ? var.ingress_black_list_rules : {}
}
resource "aws_network_acl_rule" "egress_white_list_rules" {
  for_each       = local.egress_white_list_rules
  network_acl_id = aws_network_acl.acl.id
  rule_number    = lookup(each.value, "rule_number")
  protocol       = lookup(each.value, "protocol")
  cidr_block     = lookup(each.value, "cidr_block")
  egress         = lookup(each.value, "egress")
  rule_action    = "allow"
}
resource "aws_network_acl_rule" "egress_black_list_rules" {
  for_each       = local.egress_black_list_rules
  network_acl_id = aws_network_acl.acl.id
  rule_number    = lookup(each.value, "rule_number")
  protocol       = lookup(each.value, "protocol")
  cidr_block     = lookup(each.value, "cidr_block")
  egress         = lookup(each.value, "egress")
  rule_action    = "deny"

}
resource "aws_network_acl_rule" "ingress_white_list_rules" {
  for_each       = local.ingress_white_list_rules
  network_acl_id = aws_network_acl.acl.id
  rule_number    = lookup(each.value, "rule_number")
  protocol       = lookup(each.value, "protocol")
  cidr_block     = lookup(each.value, "cidr_block")
  egress         = lookup(each.value, "egress")
  rule_action    = "allow"
}
resource "aws_network_acl_rule" "ingress_black_list_rules" {
  for_each       = local.ingress_black_list_rules
  network_acl_id = aws_network_acl.acl.id
  rule_number    = lookup(each.value, "rule_number")
  protocol       = lookup(each.value, "protocol")
  cidr_block     = lookup(each.value, "cidr_block")
  egress         = lookup(each.value, "egress")
  rule_action    = "allow"
}
