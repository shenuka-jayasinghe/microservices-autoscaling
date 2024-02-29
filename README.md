
# Microservices AWS Infrastructure

The following terraform project uses the following microservices architecture in AWS:

![Screenshot from 2023-12-08 18-31-32](https://github.com/shenuka-jayasinghe/microservices/assets/137282472/859d5ad6-c74f-4873-bbbc-b110a8fb281b)



How to use;

Step 1: After logging in to AWS in the CLI, initialise terraform in the terraform directory
```
~$ cd terraform
~/terraform$ terraform init
```
Step 2: Run terraform apply using the .tfvars file (use example.tfvars for reference)
```
~/terraform$ terraform apply -var-file=example.tfvars
```
Step 3: SSH into your servers and install your microservers
<br>
Hint: use the following commands in your ec2 to make sure the autoscaling servers will run the application on start up
```
ec2-server-ssh$ pm2 start <your application>
ec2-server-ssh$ pm2 startup
ec2-server-ssh$ pm2 save
```

Step 4: After setting up your services in your ec2s, go back to the terraform main.tf file in the root directory and uncomment the following from line 33
```bash
 module "auto_scaling" {
   source = "./modules/autoscaling"
   instance_ids = module.app_server.server_ids
   availability_zones = var.availability_zones
   security_group_id = module.security.security_group_id
   subnet_ids = module.vpc.public_subnets_ids
   target_group_ids = module.load_balancer.target_groups
   instance_names = var.server_names
 }
```
Step 5: Apply ```terraform apply -var-file=example.tfvars``` one more time, and your infrastructure will be online and ready.
