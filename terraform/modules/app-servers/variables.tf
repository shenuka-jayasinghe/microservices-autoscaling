variable "public_subnets" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

# variable "server_count" {
#   type = number
# }

variable "ssh_key" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "server_names" {
  type = list(string)
}