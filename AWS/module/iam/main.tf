
# In this module IAM Policy is created for the ec2 instnaces and Service, also attachemnt policy was added
resource "aws_iam_role" "beanstalk_service" {
  name = "${var.app_name}-eb-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role" "beanstalk_ec2" {
  name = "${var.app_name}-eb-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "beanstalk_tier" {
  role       = aws_iam_role.beanstalk_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
}

# also make use of the web tier and not the work tier
resource "aws_iam_role_policy_attachment" "beanstalk_ec2_web" {
  role       = aws_iam_role.beanstalk_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_instance_profile" "ec2_instance" {
  name = "ec2-instance_profile"
  role = aws_iam_role.beanstalk_ec2.name
}


# S3 access policies
resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.beanstalk_ec2.name
  policy_arn = var.s3_access_policy_arn
}

resource "aws_iam_role_policy_attachment" "s3_deployment_access" {
  role       = aws_iam_role.beanstalk_ec2.name
  policy_arn = var.s3_deployment_policy_arn
}