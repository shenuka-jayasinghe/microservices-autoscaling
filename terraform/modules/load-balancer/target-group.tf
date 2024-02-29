resource "aws_lb_target_group" "target_group" {
  count = length(var.services)
  name     = "${var.services[count.index].name}-target-group"
  port     = 3000
  protocol = "HTTP"
  protocol_version = "HTTP1"
  vpc_id   = var.vpc_id
  health_check {
    port     = 3000
    protocol = "HTTP"
    path = element(var.services[*].health_check_path, count.index)
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  count = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.target_group[count.index].arn
  target_id        = var.instance_ids[count.index]
  port             = 3000
}

resource "aws_lb_listener_rule" "rule" {
  listener_arn = aws_lb_listener.microservice.arn
  count = length(var.services)

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[count.index].arn
  }

  condition {
    path_pattern {
      values = [element(var.services[*].path_pattern, count.index)]
    }
  }
  
}


