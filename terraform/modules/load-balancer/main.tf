

resource "aws_lb" "load_balancer" {
  name               = "microservices"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = [for subnet_id in var.subnet_ids : subnet_id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "microservice" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[0].arn
  }
}