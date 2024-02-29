
output "servers" {
  value = module.app_server[*].app_server_output
  sensitive = true
}


output "lighting_table" {
  value = module.dynamo_db.lighting_table
  sensitive = true
}

output "heating_table" {
  value = module.dynamo_db.heating_table
  sensitive = true
}

output "server_ids" {
  value = module.app_server.server_ids
  sensitive = true
}

output "lb_dns" {
  value = module.load_balancer.lb_dns
  sensitive = true
}
