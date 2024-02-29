cidr_range         = "10.0.0.0/16"
vpc_name           = "smarthome-microservices"

availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"] # needs to be an array of 3 values
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets    = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
region             = "eu-west-2"
server_count       = 1 #one for each availability zone
ssh_key            = "key"
instance_profile_name = "ec2-dynamoDB-full-access"
server_names = [ "lighting","heating","status" ]
services = [{
  health_check_path = "/api/lights/health"
  name = "lights"
  path_pattern = "/api/lights"
},
{
  health_check_path = "/api/heating/health"
  name = "heating"
  path_pattern = "/api/heating"
},
{
  health_check_path = "/api/status/health"
  name = "status"
  path_pattern = "/api/status"
  
},
]