variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "s3_access_policy_arn" {
  description = "ARN of the S3 access policy"
  type        = string
}

variable "s3_deployment_policy_arn" {
  description = "ARN of the S3 deployment access policy"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}