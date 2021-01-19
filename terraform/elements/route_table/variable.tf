variable "name" {
  description = "The name of route table"
  type        = string
}
variable "vpc_id" {
  description = "The VPC ID launch route table"
  type        = string
}
variable "association_subnet_ids" {
  description = "Subnet IDs of attache create route table"
  type        = list(string)
}
variable "pj_prefix" {
  description = "Prefix of project"
  type        = string
}
