
# we created two bucket because one bucket is for deployment which will be used for our application that is zipped, the other bucket will be for upload anything to the application.
resource "aws_s3_bucket" "bucket_upload" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = var.tags
}

resource "aws_s3_bucket" "bucket_deployment" {
  bucket        = var.deployment_bucket_name
  force_destroy = true

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "block_public_access_uploads" {
  bucket = aws_s3_bucket.bucket_upload.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "block_public_access_deployments" {
  bucket = aws_s3_bucket.bucket_deployment.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "upload-bucket" {
  bucket = aws_s3_bucket.bucket_upload.id

  rule {
    id     = "log"
    status = "Enabled"

  filter {
    prefix = ""
  }
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "upload-deployment" {
  bucket = aws_s3_bucket.bucket_deployment.id

  rule {
    id     = "log"
    status = "Enabled"

  filter {
    prefix = ""
  }  

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
}

resource "aws_s3_bucket" "versioning_bucket_upload" {
  bucket = var.versioning_bucket
}

resource "aws_s3_bucket" "versioning_bucket_deployment" {
  bucket = var.versioning_bucket1
}

resource "aws_s3_bucket_versioning" "uploads" {
  bucket = aws_s3_bucket.bucket_upload.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "deployment" {
  bucket = aws_s3_bucket.bucket_deployment.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_policy" "s3_access" {
  name        = "${var.bucket_name}-access-policy"
  description = "Policy for accessing the uploads S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.bucket_upload.arn}/*"
        ]
      }
    ]
  })
}

# Policy for Elastic Beanstalk to access deployment artifacts
resource "aws_iam_policy" "deployment_access" {
  name        = "${var.deployment_bucket_name}-access-policy"
  description = "Policy for accessing the deployment S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.bucket_deployment.arn,
          "${aws_s3_bucket.bucket_deployment.arn}/*"
        ]
      }
    ]
  })
}