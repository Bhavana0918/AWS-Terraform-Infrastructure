provider "aws" {
  region = var.region
}

module "vpc" {
  source = "git::https://github.com/Bhavana0918/AWS-Resouce-Terraform-Code.git//vpc"

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

module "subnet" {
  source = "git::https://github.com/Bhavana0918/AWS-Resouce-Terraform-Code.git//subnet"

  vpc_id             = module.vpc.vpc_id
  cidr_blocks        = var.cidr_blocks
  availability_zones = var.availability_zones
  subnet_name        = var.subnet_name
}

module "internet_gateway" {
  source = "git::https://github.com/Bhavana0918/AWS-Resouce-Terraform-Code.git//internet_gateway"
  
  vpc_id                = module.vpc.vpc_id
  internet_gateway_name = var.internet_gateway_name
}

module "route_table" {
  source = "git::https://github.com/Bhavana0918/AWS-Resouce-Terraform-Code.git//route_table"
  cidr_blocks = var.cidr_blocks
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  route_table_name    = var.route_table_name
  subnet_ids          = module.subnet.subnet_ids
}

module "security_group" {
  source        = "git::https://github.com/Bhavana0918/AWS-Resouce-Terraform-Code.git//security_group"
  name          = var.security_group_name
  description   = var.security_group_description
  vpc_id        = module.vpc.vpc_id
  ingress_rules = var.security_group_ingress
  egress_rules  = var.security_group_egress
  tags          = var.security_group_tags
}

module "ec2" {
  source            = "git::https://github.com/Bhavana0918/AWS-Resouce-Terraform-Code.git//ec2"
  instances         = var.instances
  subnet_id         = module.subnet.subnet_ids[0]
  security_group_id = module.security_group.security_group_id
}


#load balanacer
module "alb" {
  source = "git::https://github.com/Bhavana0918/AWS-Resouce-Terraform-Code.git//load_balancer"  # Update the path if necessary

  name                        = var.alb_name
  internal                    =var.internal
  security_groups             = [module.security_group.security_group_id]
  subnets                     = module.subnet.subnet_ids
  enable_deletion_protection  = var.enable_deletion_protection
  tags                        = { Name = "app-load-balancer" }

  target_group_name           = var.target_group_name
  target_group_port           = var.target_group_port
  target_group_protocol       = var.target_group_protocol
  vpc_id                      = module.vpc.vpc_id

  health_check_healthy_threshold = var.health_check_healthy_threshold
  health_check_unhealthy_threshold = var.health_check_unhealthy_threshold
  health_check_timeout        = var.health_check_timeout
  health_check_interval       = var.health_check_interval
  health_check_path           = var.health_check_path
  health_check_matcher        = var.health_check_matcher

  listener_port               = var.listener_port
  listener_protocol           = var.listener_protocol

  #ec2_instance_ids            = { for id in module.ec2.instance_ids : id => id }
  # ec2_instance_ids = var.ec2_instance_ids
  ec2_instance_ids = var.ec2_instance_ids != null ? var.ec2_instance_ids : {}
}
