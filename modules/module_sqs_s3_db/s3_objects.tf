# variable "lambda_zips" {
#   type = map(object({
#     bucket_key = string
#     source_path = string
#   }))
#   default = {}
# }

resource "aws_s3_object" "lambda_zip" {
  for_each = var.lambda_zips

  bucket = aws_s3_bucket.this[each.value.bucket_key].id
  key    = "lambda_functions/${each.key}.zip" # Đường dẫn trên S3
  source = each.value.source_path             # Đường dẫn tệp ZIP cục bộ
  etag   = filemd5(each.value.source_path)   # Trigger update khi tệp thay đổi
}
