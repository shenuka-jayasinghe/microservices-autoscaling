variable "security_group_id" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "instance_ids" {
  type = list(string)
}


variable "subnet_ids" {
  type = list(string)
}

variable "target_group_ids" {
    type = list(string)
} 

variable "instance_names" {
  type = list(string)
}