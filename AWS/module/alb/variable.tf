# ALB variables
variable "alb_name" {
  description = "The name of the ALB"
  default = "elb-alb-demo"
  type        = string
}


variable "public_subnet_id" {
  description = "List of Public Subnet IDs where ALB should be deployed"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "health_check_path" {
  description = "Health check path for the ALB target group"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "Number of successful health checks before considering an instance healthy"
  type        = number
  default     = 3
}

variable "unhealthy_threshold" {
  description = "Number of failed health checks before considering an instance unhealthy"
  type        = number
  default     = 3
}


# variable "lb_name" {
#   description = "Name of the Load Balancer"
#   type        = string
#   default     = "elb-alb"
# }


variable "lb_security_group_id" {
  description = "Security Group ID for Load Balancer"
  type        = list
}

variable "certificate_arn" {
  description = "SSL Certificate ARN"
  type        = string
  default     = ""  # Optional if only HTTP is used
}

variable "target_group_name" {
  description = "Name for the target group"
  type        = string
}