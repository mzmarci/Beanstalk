variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  default = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
}
variable "public_subnet_cidrs" {
  description = "Public Subnet CIDR values"
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "ec2_ami" {
  description = "this is a variable to manage ec2_ami type"
  type        = string
}

variable "ec2_instance_type" {
  description = "this is a variable to manage ec2_instance_type"
  type        = string
  default     = "t2.medium"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "elb-demo"
}


# RDS Variables
variable "db_allocated_storage" {
  description = "Allocated storage for RDS instance in GB"
  type        = number
  default     = 20
}

variable "db_instance_class" {
  description = "Instance class for RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "marci"
}

variable "db_username" {
  description = "Username for the database"
  type        = string
  default     = "elbadmin"
}


# Elastic Beanstalk Variables
variable "eb_instance_type" {
  description = "Instance type for Elastic Beanstalk"
  type        = string
  default     = "t2.medium"
}

variable "eb_min_instances" {
  description = "Minimum number of instances"
  type        = number
  default     = 1
}

variable "eb_max_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 2
}



