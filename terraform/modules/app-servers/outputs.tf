
output "app_public_ips" {
  value = aws_instance.app_server[*].public_ip
}

output "app_public_dns" {
  value = aws_instance.app_server[*].public_dns
}

output "server_ids" {
  value = aws_instance.app_server[*].id
}


output "app_server_output" {
  value = [for server in aws_instance.app_server[*] : {
    name : server.tags_all.Name
    pub_ip: server.public_ip
    dns: server.public_dns
    subnet: server.subnet_id
    id: server.id
  }]
}

