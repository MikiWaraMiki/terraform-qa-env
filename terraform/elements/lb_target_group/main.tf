resource "aws_lb_target_group" "lb_target_group" {
  name                          = var.name
  vpc_id                        = var.vpc_id
  target_type                   = var.target_type
  port                          = var.port
  protocol                      = var.protocol
  deregistration_delay          = var.deregistration_delay
  slow_start                    = var.slow_start
  load_balancing_algorithm_type = var.load_balancing_algorithm_type

  dynamic "health_check" {
    for_each = var.is_create_health_check ? [var.health_check_params] : []

    path                = lookup(health_check.value, "path", null)
    healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
    unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
    timeout             = lookup(health_check.value, "timeout", null)
    interval            = lookup(health_check.value, "interval", null)
    matcher             = lookup(health_check.value, "matcher", null)
    port                = lookup(health_check.value, "port", null)
    protocol            = lookup(health_check.value, "protocol", null)
  }
}
