variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}
variable "availability_zone" {
  description = "The AZ for the subnet"
  type        = string
}
variable "cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
}
variable "name" {
  description = "Name for the subnet"
  type        = string
}
variable "pj_prefix" {
  description = "Prefix of the project"
  type        = string
}
