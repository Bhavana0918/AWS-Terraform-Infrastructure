region = "us-east-1"


#VPC
vpc_cidr = "10.0.0.0/16"
vpc_name = "my-vpc"


#Subnet
vpc_id             = "vpc-12345678"
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
  },
  {
    instance_name = "WebServer2"
    instance_type = "t2.medium"
    ami           = "ami-0d191299f2822b1fa" # Replace with a valid AMI ID
    key_name      = "demo-key"
    os_type       = "windows"
  },
  {
    instance_name = "DBServer"
    instance_type = "t2.large"
    ami           = "ami-0069eac59d05ae12b" # Replace with a valid AMI ID
    key_name      = "demo-key"
    os_type       = "linux"
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
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "Allow RDP from anywhere"
    from_port   = 3389
    to_port     = 3389
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }
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



#alb

alb_name                   = "app-load-balancer"
internal                   = false
enable_deletion_protection = false

target_group_name     = "app-target-group"
target_group_port     = 22
target_group_protocol = "SSH"

health_check_healthy_threshold   = 3
health_check_unhealthy_threshold = 5
health_check_timeout             = 50
health_check_interval            = 60
health_check_path                = "/"
health_check_matcher             = "200"

listener_port     = 22
listener_protocol = "SSH"

ec2_instance_ids = {
  "WebServer1" = "i-02005860a72c9f368"
  "WebServer2" = "i-02e13b508963e56d1"
  "DBServer"   = "i-00c3d120f70ff29bd"
}
