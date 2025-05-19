output "eb_service_role_arn" {
  description = "ARN of the Elastic Beanstalk service role"
  value       = aws_iam_role.beanstalk_service.arn
}

output "eb_ec2_role_arn" {
  description = "ARN of the Elastic Beanstalk EC2 role"
  value       = aws_iam_role.beanstalk_ec2.arn
}

output "eb_ec2_instance_profile_name" {
  description = "Name of the Elastic Beanstalk EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_instance.name
}

output "eb_ec2_instance_profile_arn" {
  description = "ARN of the Elastic Beanstalk EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_instance.arn
}