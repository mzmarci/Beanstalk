variable "app_name" {
  description = "Name of the Elastic Beanstalk application"
  type        = string
}

variable "app_description" {
  description = "Description of the Elastic Beanstalk application"
  type        = string
  default     = ""
}

variable "environment_name" {
  description = "Name of the environment"
  type        = string
}

variable "service_role_arn" {
  description = "ARN of the Elastic Beanstalk service role"
  type        = string
}

variable "solution_stack_name" {
  description = "Solution stack name for the Beanstalk environment"
  type        = string
  default     = "64bit Amazon Linux 2023 v4.4.2 running Python 3.8" # Updated to Amazon Linux 2023 with Python 3.8
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type for the environment"
  type        = string
  default     = "t3.micro"
}

variable "min_instances" {
  description = "Minimum number of instances"
  type        = number
  default     = 1
}

variable "max_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 2
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

# variable "aws_account_id" {
#   description = "AWS account ID"
#   type        = string
# }

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the load balancer"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "instance_profile_name" {
  description = "Name of the instance profile for EC2 instances"
  type        = string
}

variable "instance_security_group_id" {
  description = "ID of the security group for EC2 instances"
  type        = string
}

variable "lb_security_group_id" {
  description = "ID of the security group for ALB"
  type        = string
}

variable "uploads_bucket_name" {
  description = "Name of the S3 bucket for uploads"
  type        = string

}