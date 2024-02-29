module "vpc" {
  source             = "./modules/vpc"
  cidr_range         = var.cidr_range
  vpc_name           = var.vpc_name
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "app_server" {
  source            = "./modules/app-servers"
  public_subnets    = module.vpc.public_subnets_ids
  security_group_id = module.security.security_group_id
  ssh_key           = var.ssh_key
  instance_profile_name = var.instance_profile_name
  server_names = var.server_names
}

module "load_balancer" {
  source = "./modules/load-balancer"
  vpc_id = module.vpc.vpc_id
  security_groups = [module.security.security_group_id]
  subnet_ids = module.vpc.public_subnets_ids
  instance_ids = module.app_server.server_ids
  services = var.services
}

# module "auto_scaling" {
#   source = "./modules/autoscaling"
#   instance_ids = module.app_server.server_ids
#   availability_zones = var.availability_zones
#   security_group_id = module.security.security_group_id
#   subnet_ids = module.vpc.public_subnets_ids
#   target_group_ids = module.load_balancer.target_groups
#   instance_names = var.server_names
# }



module "dynamo_db" {
  source = "./modules/dynamo-db"
}