resource "aws_instance" "app_server" {
  count         = length(var.server_names)
  ami           = "ami-0505148b3591e4c07"
  instance_type = "t2.micro"
  subnet_id     = var.public_subnets[0]

  tags = {
    Name = format("%s_server_01", element(var.server_names, count.index))
  }
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.ssh_key
  iam_instance_profile = var.instance_profile_name
}


