variable "cidr_range" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "region" {
  type = string
}

variable "server_count" {
  type = number
}

variable "ssh_key" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "server_names" {
 type = list(string) 
}

variable "services" {
  type = list(object({
    name = string,
    health_check_path = string,
    path_pattern = string
  }))
}