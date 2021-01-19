# VPC Parameter
variable "pj_prefix" {
  type    = string
  default = "project pjrefix"
}
variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidrblock"
}
variable "enable_dns_support" {
  type        = bool
  description = "Whether or not the VPC has DNS hostname support. default is true"
  default     = true
}
variable "enable_dns_hostnames" {
  type        = bool
  description = "Whether or not the VPC has Classiclink enabled. default is true"
  default     = true
}
variable "instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr."
  default     = "default"
}
variable "public_subnet_parameters" {
  /*
  以下のようなパラメータで入ってくる
  {
    1a: {
      name: "any string",
      cidr: "any string",
      az: "any string"
    },
    1c: {
      name: "any string"
      ...
    }
  }
  */
  type        = map(map(string))
  description = "public subnet parameters"
}
variable "private_subnet_parameters" {
  type        = map(map(string))
  description = "private subnet parameters"
}
variable "natgw_counts" {
  type        = number
  description = "nat gw counts"
}
