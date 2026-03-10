
#cap nhat code de S3 ho tro versioning va ma hoa:
resource "aws_s3_bucket" "this" {
  for_each = var.s3_buckets

  bucket = "${each.value.name}"
  # tags = {
  #   Name = "${var.owner}_${var.application}_${var.environment}"
  # }
}

resource "aws_s3_bucket_versioning" "this" {
  for_each = var.s3_buckets

  bucket = aws_s3_bucket.this[each.key].id
  versioning_configuration {
    status = "Enabled" # Bật versioning cho bucket
  }
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  for_each = { for k, v in var.s3_buckets : k => v if can(regex(".*-fe-source.*", v.name)) }
  

  bucket = aws_s3_bucket.this[each.key].id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# S3 CORS Configuration cho assets bucket
resource "aws_s3_bucket_cors_configuration" "assets_bucket_cors" {
  # for_each = { for k, v in var.s3_buckets : k => v if v.name == "prod-wdr-maritimeapps-deploy-lambda-assets6" }
  for_each = { for k, v in var.s3_buckets : k => v if can(regex(".*-assets.*", v.name)) }


  bucket = aws_s3_bucket.this[each.key].id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "DELETE", "HEAD"]
    allowed_origins = ["https://d2o32ci9a5hhym.cloudfront.net", "http://localhost:*"]  #FE cloudfront domain
    expose_headers  = [
      "ETag",
      "x-amz-server-side-encryption",
      "x-amz-request-id",
      "x-amz-id-2",
      "x-amz-version-id",
      "x-amz-delete-marker"
    ]
    max_age_seconds = 3600
  }

  # Đảm bảo bucket đã được tạo trước khi tạo CORS
  depends_on = [aws_s3_bucket.this]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  for_each = var.s3_buckets

  bucket = aws_s3_bucket.this[each.key].id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" # Bật mã hóa
    }
  }
}
 
# Cấu hình block public access cho S3 buckets - ENABLED (all buckets private)
resource "aws_s3_bucket_public_access_block" "this" {
  for_each = var.s3_buckets
  bucket = aws_s3_bucket.this[each.key].id
  
  # Tất cả buckets đều private (block public access = ON)
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 bucket policy cho FE bucket - DISABLED (keep manual setup)
# resource "aws_s3_bucket_policy" "cloudfront_access_fe" {
#   for_each = { for k, v in var.s3_buckets : k => v if can(regex(".*-fe-source.*", v.name)) }
#   bucket = aws_s3_bucket.this[each.key].id
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = "*",
#         Action = "s3:GetObject",
#         Resource = "${aws_s3_bucket.this[each.key].arn}/*"
#       }
#     ]
#   })
#   
#   # Đảm bảo bucket và public access block đã được tạo trước khi tạo policy
#   depends_on = [aws_s3_bucket.this, aws_s3_bucket_public_access_block.this]
# }

