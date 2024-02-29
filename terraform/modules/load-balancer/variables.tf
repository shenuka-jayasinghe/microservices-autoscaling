variable "vpc_id" {
  type = string
}

variable "instance_ids" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "services" {
  type = list(object({
    name = string,
    health_check_path = string,
    path_pattern = string
  }))
}

