#AWS region
variable "region" {
  default     = "us-east-1"
  type        = string
  description = "AWS Region"
}

#EC2 instance
variable "instances" {
  description = "List of maps containing instance configurations"
  type = list(object({
    instance_name = string
    instance_type = string
    ami           = string
    key_name      = string
    os_type       = string
    user_data     = string

  }))
}


#VPC
variable "vpc_cidr" {
  description = "vpc cidr"
  type        = string
}

variable "vpc_name" {
  description = "vpc name"
  type        = string
}



#Subnet

# variable "vpc_id" {
#   description = "The ID of the VPC"
# }


variable "cidr_blocks" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}


#internet_gateway
variable "internet_gateway_name" {
  type        = string
  description = "Name of Internet gatway"

}

#route_table_name     = "public-route-table"
variable "route_table_name" {
  type        = string
  description = "route table name "

}


# Security Group
variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}

variable "security_group_description" {
  description = "The description of the security group"
  type        = string
}

variable "security_group_ingress" {
  description = "The ingress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "security_group_egress" {
  description = "The egress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "security_group_tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {}
}

#ALB security group variables
variable "alb_security_group_name" {
  description = "The name of the security group"
  type        = string
}

variable "alb_security_group_description" {
  description = "The description of the security group"
  type        = string
}

variable "alb_security_group_ingress" {
  description = "The ingress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "alb_security_group_egress" {
  description = "The egress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "alb_security_group_tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {}
}

#lg

variable "alb_name" {
  description = "The name of the ALB"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "The type of load balancer"
  type        = string
  default     = "application"
}


variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "target_group_name" {
  description = "The name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "The port on which the target group is listening"
  type        = number
}

variable "target_group_protocol" {
  description = "The protocol for the target group"
  type        = string
}

variable "health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = number
  default     = 3
}

variable "health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering a target unhealthy"
  type        = number
  default     = 3
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check"
  type        = number
  default     = 5
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target"
  type        = number
  default     = 30
}

variable "health_check_path" {
  description = "The destination for the health check request"
  type        = string
  default     = "/"
}

variable "health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target"
  type        = string
  default     = "200"
}

variable "listener_port" {
  description = "The port on which the ALB is listening"
  type        = number
}

variable "listener_protocol" {
  description = "The protocol for the ALB listener"
  type        = string
}

variable "ec2_instance_ids" {
  description = "A map of EC2 instance IDs to attach to the target group"
  type        = map(string)
}

