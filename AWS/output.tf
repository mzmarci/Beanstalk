output "s3_bucket_name" {
  description = "Name of the uploads S3 bucket"
  value       = module.s3.bucket_name
}

output "deployment_bucket_name" {
  description = "Name of the deployment S3 bucket"
  value       = module.s3.deployment_bucket_name
}

# output "rds_endpoint" {
#   description = "Endpoint of the RDS instance"
#   value       = module.rds.endpoint
# }

output "elastic_beanstalk_environment_name" {
  description = "Name of the Elastic Beanstalk environment"
  value       = module.elastic_beanstalk.environment_name
}

output "elastic_beanstalk_environment_id" {
  description = "ID of the Elastic Beanstalk environment"
  value       = module.elastic_beanstalk.environment_id
}

output "elastic_beanstalk_url" {
  description = "URL of the Elastic Beanstalk environment"
  value       = module.elastic_beanstalk.ebs-url
}

output "cname" {
  description = "Name of the Elastic Beanstalk cname"
  value       = module.elastic_beanstalk.cname

}