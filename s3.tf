# Generate unique ID for bucket name
resource "random_id" "bucket_id" {
  byte_length = 4
}

# S3 bucket (no ACL)
resource "aws_s3_bucket" "frontend_assets" {
  bucket = "ecommerce-frontend-assets-${random_id.bucket_id.hex}"

  tags = {
    Name = "Frontend Bucket"
  }
}

# Ownership controls to enforce BucketOwnerEnforced
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.frontend_assets.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Website hosting configuration
resource "aws_s3_bucket_website_configuration" "frontend_assets_website" {
  bucket = aws_s3_bucket.frontend_assets.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
