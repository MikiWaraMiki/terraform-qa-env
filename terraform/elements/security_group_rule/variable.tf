variable "security_group_id" {
  description = "The security group to apply this rule to."
  type        = string
}
variable "type" {
  description = "The type of rule being created. Valid options are ingress (inbound) or egress (outbound)."
  type        = string
  validation {
    condition     = var.type == "ingress" || var.type == "egress"
    error_message = "The type is ingress or egress only."
  }
}
variable "from_port" {
  description = "The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')."
  type        = number
}
variable "to_port" {
  description = "(Required) The end port (or ICMP code if protocol is 'icmp')."
  type        = number
}
variable "protocol" {
  description = "The protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
  type        = string
}
variable "cidr_blocks" {
  description = "(Optional) List of CIDR blocks. Cannot be specified with source_security_group_id"
  type        = list(string)
  default     = null
}
variable "source_security_group_id" {
  description = "The security group id to allow access to/from, depending on the type. Cannot be specified with cidr_blocks and self"
  type        = string
  default     = null
}
variable "description" {
  description = "Description of the rule."
  type        = string
}
