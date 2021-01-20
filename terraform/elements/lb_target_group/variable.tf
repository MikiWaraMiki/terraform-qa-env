variable "name" {
  description = "The name of target group"
  type        = string
}
variable "vpc_id" {
  description = "The identifier of the VPC in which to create the target group."
  type        = string
}
variable "target_type" {
  description = "The type of target that you must specify when registering targets with this target group."
  type        = string
  validation {
    condition     = var.target_type == "instance" || var.taget_type == "ip" || var.target_type == "lambda"
    error_message = "The value is 'instance' or 'lambda' or 'ip' only."
  }
}
variable "port" {
  description = " The protocol to use for routing traffic to the targets."
  type        = number
  default     = null
}
variable "protocol" {
  description = "The protocol"
  type        = string
  default     = "HTTP"
}
variable "deregistration_delay" {
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused"
  type        = number
  default     = 300
}
variable "slow_start" {
  description = "The amount time for targets to warm up before the load balancer sends them a full share of requests."
  type        = number
  default     = 300
}
variable "load_balancing_algorithm_type" {
  description = "Determines how the load balancer selects targets when routing requests. "
  type        = string
  default     = "round_robin"
}

/*
  以下のようなパラメータで入ってくる想定
  {
    path: "/",
    healthy_threshold: 5,
    unhealthy_threshold: 2,
    timeout: 5,
    interval: 30,
    matcher: 200,
    port: "traffic-port",
    protocol: "HTTP"
  }
*/
variable "health_check_params" {
  description = "A Health Check block params"
}
