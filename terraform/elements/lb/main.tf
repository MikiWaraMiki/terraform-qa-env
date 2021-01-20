resource "aws_lb" "lb" {
  name                       = var.name
  load_balancer_type         = var.load_balancer_type
  internal                   = var.internal
  security_groups            = var.security_groups
  subnets                    = var.subnets
  enable_deletion_protection = var.enable_deletion_protection
  enable_http2               = var.enable_http2

  # TODO: AccessLogを任意で作成できるように

  tags = {
    Name : var.name
    PJPrefix : var.pj_prefix
  }
}
