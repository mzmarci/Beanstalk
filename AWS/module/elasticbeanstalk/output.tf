output "environment_name" {
  description = "Name of the Beanstalk environment"
  value       = aws_elastic_beanstalk_environment.env.name
}

output "environment_id" {
  description = "ID of the Beanstalk environment"
  value       = aws_elastic_beanstalk_environment.env.id
}

output "ebs-url" {
  description = "elastic beanstalk URL"
  value       = aws_elastic_beanstalk_environment.env.endpoint_url
}

output "cname" {
  description = "elastic beanstalk CNAME"
  value       = aws_elastic_beanstalk_environment.env.cname
}