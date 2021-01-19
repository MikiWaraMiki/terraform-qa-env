variable "route_table_id" {
  description = "The Route Table ID for route"
  type        = string
}
variable "gateway_id" {
  description = "The Internet Gateway ID"
  type        = string
  default     = null
}
variable "nat_gateway_id" {
  description = "The Nat Gateway ID"
  type        = string
  default     = null
}
variable "vpc_endpoint_id" {
  description = "The VPC endpoint ID"
  type        = string
  default     = null
}
variable "destination_cidr_block" {
  description = "destination cidr block"
  type        = string
  default     = "0.0.0.0/0"
}
