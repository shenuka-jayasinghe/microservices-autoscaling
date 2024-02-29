run "app_server_sg_id" {


variables {
    cidr_range         = "10.0.0.0/16"
vpc_name           = "test-microservices-vpc"
availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets    = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
region             = "eu-west-2"
server_count = 2
}
#   assert {
#     count = server_count
#     condition     = module.app_server.vpc_security_group_ids[*]. == [module.security.security_group_id]
#     error_message = "App server module should have property vpc_security_group_ids"
#   }


}