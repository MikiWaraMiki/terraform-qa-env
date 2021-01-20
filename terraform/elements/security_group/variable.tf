variable "vpc_id" {
  description = "The VPC ID launch security group"
  type        = string
}
variable "name" {
  description = "The name of security group"
  type        = string
}
variable "description" {
  description = "The description of security group"
  type        = string
}
variable "pj_prefix" {
  description = "Project Prefix"
  type        = string
}
