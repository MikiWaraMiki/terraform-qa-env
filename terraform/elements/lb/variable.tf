variable "name" {
  description = "The name of the LB"
  type        = string
}
variable "pj_prefix" {
  description = "Project Prefix"
  type        = string
}
variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are application, gateway, or network. The default value is application"
  type        = string
  default     = "application"
}
variable "internal" {
  description = " If true, the LB will be internal. default is false."
  type        = bool
  default     = false
}
variable "security_groups" {
  description = " A list of security group IDs to assign to the LB. Only valid for Load Balancers of type application."
  type        = list(string)
  default     = null
}
variable "subnets" {
  description = "A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type network"
  type        = list(string)
  default     = null
}
variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. "
  type        = bool
  default     = false
}
variable "enable_http2" {
  description = "Indicates whether HTTP/2 is enabled in application load balancers. Defaults to true"
  type        = bool
  default     = true
}
