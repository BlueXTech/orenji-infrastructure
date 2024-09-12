resource "aws_alb" "alb" {
  name                       = "ALB-${var.environment}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sg_alb_allow_all_https.id]  
  subnets                    = var.subnets
  enable_deletion_protection = var.alb_enable_deletion_protection
  ip_address_type = "ipv4"

  tags = {
    Name = "ALB-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  protocol          = "HTTPS"
  port              = 443
  ssl_policy        = var.alb_listener_ssl_policy
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
}