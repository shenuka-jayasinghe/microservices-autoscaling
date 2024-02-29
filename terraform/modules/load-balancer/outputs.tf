output "lb_dns" {
  value = aws_lb.load_balancer.dns_name
}

output "target_groups" {
  value = aws_lb_target_group.target_group[*].id
}
