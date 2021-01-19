variable "pj_prefix" {
  type    = string
  default = "project pjrefix"
}
variable "cidr_block" {
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
  validation {
    condition     = var.instance_tenancy == "default" || var.instance_tenancy == "dedicated"
    error_message = "Instance_tenancy is default or dedicated."
  }
}
