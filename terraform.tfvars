region = "us-east-1"


#VPC
vpc_cidr = "10.0.0.0/16"
vpc_name = "my-vpc"


#Subnet
# vpc_id             = "vpc-12345678"
cidr_blocks        = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
subnet_name        = "public-subnet"

#internet_gateway
internet_gateway_name = "my-internet-gateway"

#route_table
route_table_name = "public-route-table"

#EC@
instances = [
  {
    instance_name = "WebServer1"
    instance_type = "t2.micro"
    ami           = "ami-00beae93a2d981137" # Replace with a valid AMI ID
    key_name      = "demo-key"
    os_type       = "linux"
    user_data     = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello Valtech</h1>" > /var/www/html/index.html
EOF
  },
  {
    instance_name = "DBServer"
    instance_type = "t2.micro"
    ami           = "ami-00beae93a2d981137" # Replace with a valid AMI ID
    key_name      = "demo-key"
    os_type       = "linux"
    user_data     = <<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello India</h1>" > /var/www/html/index.html
EOF
  }
]


# Security Group
security_group_name        = "demo-security-group"
security_group_description = "sg-for-ec2"
security_group_ingress = [
  {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # ,
  # {
  #   description = "Allow RDP from anywhere"
  #   from_port   = 3389
  #   to_port     = 3389
  #   protocol    = "6"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
]

security_group_egress = [
  {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

security_group_tags = {
  Name = "demo-security-group"
}


#ALB -SG
alb_security_group_name        = "alb-security-group"
alb_security_group_description = "security group attach to loadbalancer allow SSH"
alb_security_group_ingress = [
  {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

alb_security_group_egress = [
  {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

alb_security_group_tags = {
  Name = "alb-security-group"
}


#alb

alb_name                   = "app-load-balancer"
internal                   = false
enable_deletion_protection = false

target_group_name     = "app-target-group"
target_group_port     = 80
target_group_protocol = "HTTP"


health_check_healthy_threshold   = 2
health_check_unhealthy_threshold = 2
health_check_timeout             = 5
health_check_interval            = 30

health_check_path                = "/"
health_check_matcher             = "200"

listener_port     = 80
listener_protocol = "HTTP"

ec2_instance_ids = {
"WebServer1"="i-0c1b20354895dbf2d"
"DBServer"= "i-096eddc83265008ba"

}

