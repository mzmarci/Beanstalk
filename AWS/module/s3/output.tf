output "bucket_name" {
  description = "The name of the uploads bucket"
  value       = aws_s3_bucket.bucket_upload.id
}

output "deployment_bucket_name" {
  description = "The name of the deployment bucket"
  value       = aws_s3_bucket.bucket_deployment.id
}

output "bucket_arn" {
  description = "The ARN of the uploads bucket"
  value       = aws_s3_bucket.bucket_upload.arn
}

output "deployment_bucket_arn" {
  description = "The ARN of the deployment bucket"
  value       = aws_s3_bucket.bucket_deployment.arn
}

output "access_policy_arn" {
  description = "The ARN of the bucket access policy"
  value       = aws_iam_policy.s3_access.arn
}

output "deployment_access_policy_arn" {
  description = "The ARN of the deployment bucket access policy"
  value       = aws_iam_policy.deployment_access.arn
}