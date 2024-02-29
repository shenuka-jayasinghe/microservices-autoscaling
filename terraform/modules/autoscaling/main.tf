resource "aws_ami_from_instance" "server_ami" {
  count = length(var.instance_names)
  name               = format("%s-ami", element(var.instance_names, count.index))
  source_instance_id = var.instance_ids[count.index]
}

resource "aws_launch_template" "server_template" {
  name_prefix   = "microservice"
  count = length(var.instance_names)
  image_id      = aws_ami_from_instance.server_ami[count.index].id
  instance_type = "t2.micro"
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.security_group_id]
  }
  monitoring {
    enabled = true
  }
}

resource "aws_autoscaling_group" "server_asg" {
  count = length(var.instance_names)
  name = format("%s-asg", element(var.instance_names, count.index))
  # desired_capacity   = 2
  max_size           = 5
  min_size           = 1
  vpc_zone_identifier = [var.subnet_ids[1],var.subnet_ids[2]]

  launch_template {
    id      = aws_launch_template.server_template[count.index].id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = format("%s_auto_spawn", element(var.instance_names, count.index))
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }
  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity","GroupInServiceInstances","GroupTotalInstances"]
  metrics_granularity = "1Minute"
}


resource "aws_autoscaling_attachment" "server_asg_attachment" {
  count = length(var.instance_names)
  autoscaling_group_name = aws_autoscaling_group.server_asg[count.index].id
  lb_target_group_arn    = var.target_group_ids[count.index]
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = format("%s-asg-scale-down-policy", element(var.instance_names, count.index))
  count = length(var.instance_names)
  autoscaling_group_name = aws_autoscaling_group.server_asg[count.index].name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  count = length(var.instance_names)
  alarm_name          = "cpu_scaledown_${var.instance_names[count.index]}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120  
  statistic           = "Average"
  threshold           = 20

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.server_asg[count.index].name
  }

  alarm_actions = [aws_autoscaling_policy.scale_down[count.index].arn]
}

resource "aws_autoscaling_policy" "scale_up" {
  name                   = format("%s-asg-scale-up-policy", element(var.instance_names, count.index))
  count = length(var.instance_names)
  autoscaling_group_name = aws_autoscaling_group.server_asg[count.index].name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}



resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  count = length(var.instance_names)
  alarm_name          = "cpu_alarm_${var.instance_names[count.index]}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120  
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.server_asg[count.index].name
  }

  alarm_actions = [aws_autoscaling_policy.scale_up[count.index].arn]
}