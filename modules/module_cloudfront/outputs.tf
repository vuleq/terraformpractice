output "cloudfront_distribution_ids" {
  description = "CloudFront distribution IDs"
  value = {
    for k, dist in aws_cloudfront_distribution.this : k => dist.id
  }
}

output "domain_name" {
  description = "CloudFront distribution domain names"
  value = {
    for k, dist in aws_cloudfront_distribution.this : k => dist.domain_name
  }
}

output "distribution_arns" {
  description = "CloudFront distribution ARNs"
  value = {
    for k, dist in aws_cloudfront_distribution.this : k => dist.arn
  }
}

# Origin Access Control IDs - comment lại khi không dùng OAC
# output "origin_access_control_ids" {
#   description = "Origin Access Control IDs for S3 buckets"
#   value = {
#     for k, oac in aws_cloudfront_origin_access_control.s3_oac : k => oac.id
#   }
# }


output "cloudfront_function_arns" {
  description = "ARNs of CloudFront functions"
  value = {
    # fe = aws_cloudfront_function.fe_function.arn  # COMMENT LẠI vì chỉ dùng BE function
    be = aws_cloudfront_function.be_function.arn
  }
}