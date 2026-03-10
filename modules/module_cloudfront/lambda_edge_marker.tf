# Marker-based Lambda@Edge Functions
# File: lambda_edge_marker.tf

# Marker-based replacement locals
locals {
  # Read template files from folders
  cors_template = file("${path.module}/lambda_templates/be/cors.mjs")
  csp_template  = file("${path.module}/lambda_templates/fe/csp.mjs")
  
  # Generate replacement content for CORS
  cors_replacement = <<-CORS
// TERRAFORM_REPLACE_START:CORS_ORIGINS
const ALLOWED_ORIGINS = [
${join(",\n", [for origin in var.cors_origins : "    '${origin}'"])}
];
// TERRAFORM_REPLACE_END:CORS_ORIGINS
CORS

  # Generate replacement content for CSP
  csp_replacement = <<-CONFIG
// TERRAFORM_REPLACE_START:CSP_CONFIG
const CONFIG = {
  S3_BUCKET_NAME: '${var.csp_config.s3_bucket_name}',
  S3_REGION: '${var.csp_config.s3_region}',
  API_CLOUDFRONT_DOMAIN: '${var.csp_config.api_cloudfront_domain}',
  COGNITO_REGION: '${var.csp_config.cognito_region}',
  COGNITO_USER_POOL_ID: '${var.csp_config.cognito_user_pool_id}',
  S3_ASSETS_BUCKET: '${var.csp_config.s3_assets_bucket}',
  ADDITIONAL_CONNECT_SRC: '${var.csp_config.additional_connect_src}',
  ADDITIONAL_IMG_SRC: '${var.csp_config.additional_img_src}'
};
// TERRAFORM_REPLACE_END:CSP_CONFIG
CONFIG

  # Replace using regex patterns
  cors_code = replace(
    local.cors_template,
    "/(?s)// TERRAFORM_REPLACE_START:CORS_ORIGINS.*?// TERRAFORM_REPLACE_END:CORS_ORIGINS/",
    local.cors_replacement
  )
  
  csp_code = replace(
    local.csp_template,
    "/(?s)// TERRAFORM_REPLACE_START:CSP_CONFIG.*?// TERRAFORM_REPLACE_END:CSP_CONFIG/",
    local.csp_replacement
  )
  
  # Validation
  cors_has_markers = can(regex("TERRAFORM_REPLACE_START:CORS_ORIGINS", local.cors_template))
  csp_has_markers = can(regex("TERRAFORM_REPLACE_START:CSP_CONFIG", local.csp_template))
}

# Sử dụng chung IAM Role với Lambda functions thông thường
# Sử dụng ARN trực tiếp thay vì data source
locals {
  # Sử dụng role đã được update với trust policy cho Lambda@Edge
  # NOTE: Khi copy sang project khác, đảm bảo cung cấp lambda_edge_role_arn qua variable
  # Hoặc update hardcoded ARN fallback này phù hợp với project mới
  lambda_edge_role_arn = var.lambda_edge_role_arn != null ? var.lambda_edge_role_arn : "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
}

# Sử dụng chung IAM Role với Lambda functions thông thường
# Role: prod_wdr_maritimeapps_deploy_app_lambda đã có đủ quyền
# - Assume role policy cho lambda.amazonaws.com và edgelambda.amazonaws.com
# - Đã có sẵn các permissions cần thiết cho Lambda và Lambda@Edge

# Validation resource
resource "null_resource" "validate_markers" {
  triggers = {
    # Only trigger when template files change, not every time
    cors_template_hash = filemd5("${path.module}/lambda_templates/be/cors.mjs")
    csp_template_hash = filemd5("${path.module}/lambda_templates/fe/csp.mjs")
    # Also trigger when variables change
    cors_origins = join(",", var.cors_origins)
    csp_config = jsonencode(var.csp_config)
  }

  provisioner "local-exec" {
    command = <<-EOT
      ${local.cors_has_markers ? "echo '✓ CORS markers found'" : "echo '✗ CORS markers missing'"}
      ${local.csp_has_markers ? "echo '✓ CSP markers found'" : "echo '✗ CSP markers missing'"}
    EOT
  }
}

# Write processed code to files
resource "local_file" "cors_processed" {
  content  = local.cors_code
  filename = "${path.module}/lambda_templates/be/index.mjs"  # BE folder với index.mjs
  
  depends_on = [null_resource.validate_markers]
}

resource "local_file" "csp_processed" {
  content  = local.csp_code
  filename = "${path.module}/lambda_templates/fe/index.mjs"  # FE folder với index.mjs
  
  depends_on = [null_resource.validate_markers]
}

# Create ZIP files for Lambda Edge functions
resource "archive_file" "cors_zip" {
  type        = "zip"
  source_file = local_file.cors_processed.filename
  output_path = "${path.module}/lambda_templates/cors_processed.zip"
  
  depends_on = [local_file.cors_processed]
}

resource "archive_file" "csp_zip" {
  type        = "zip"
  source_file = local_file.csp_processed.filename
  output_path = "${path.module}/lambda_templates/csp_processed.zip"
  
  depends_on = [local_file.csp_processed]
}

# Marker-based Lambda@Edge Functions - REMOVED
# Chỉ dùng edge_function_versions_marker để tránh conflict

# Lambda@Edge Functions (với versions)
# Sử dụng variable lambda_edge_function_names để parameterize function names
# Key phải chứa "FE" hoặc "BE" để xác định template nào sẽ dùng
resource "aws_lambda_function" "edge_function_versions_marker" {
  for_each = var.enable_lambda_edge ? var.lambda_edge_function_names : {}
  
  provider = aws.us_east_1
  
  function_name = each.key
  role = local.lambda_edge_role_arn
  handler       = "index.handler"
  runtime       = each.value.runtime
  timeout       = each.value.timeout
  memory_size   = each.value.memory_size
  
  # Use ZIP files for Lambda Edge functions
  # FE = CSP (Content Security Policy), BE = CORS (Cross-Origin Resource Sharing)
  # Use pattern matching: if key contains "FE" use CSP, if contains "BE" use CORS
  filename = can(regex(".*FE.*", each.key)) ? archive_file.csp_zip.output_path : archive_file.cors_zip.output_path
  source_code_hash = can(regex(".*FE.*", each.key)) ? archive_file.csp_zip.output_base64sha256 : archive_file.cors_zip.output_base64sha256
  
  # Publish version để có qualified_arn cho CloudFront
  publish = true
  
  tags = {
    Owner       = var.owner
    Application = var.application
    Environment = var.environment
  }
  
  depends_on = [
    null_resource.validate_markers,
    local_file.cors_processed,
    local_file.csp_processed,
    archive_file.cors_zip,
    archive_file.csp_zip
  ]
}

# Data source để lấy Lambda Edge ARN hiện tại từ AWS (fallback khi plan)
# Giải quyết vấn đề: qualified_arn là "known after apply" khi code thay đổi
# 
# LƯU Ý QUAN TRỌNG: Data source này sẽ FAIL khi functions chưa tồn tại (tạo mới lần đầu)
# Terraform không hỗ trợ optional data sources. Có 2 giải pháp:
# 
# Option 1 (Đang dùng): Dùng try() trong output - nhưng data source vẫn fail khi plan
#   → Giải pháp: Chạy terraform apply 2 lần:
#      - Lần 1: Tạo functions (ignore data source errors)
#      - Lần 2: Associate với CloudFront (data source đã có ARN)
#
# Option 2 (Khuyến nghị khi copy sang project mới): Comment data source khi tạo mới lần đầu
#   → Uncomment sau khi functions đã được tạo
#
# Khi copy sang project mới: Nên comment data source này, uncomment sau khi apply lần đầu thành công
data "aws_lambda_function" "existing_edge_functions" {
  for_each = var.enable_lambda_edge ? var.lambda_edge_function_names : {}
  
  provider     = aws.us_east_1
  function_name = each.key
}

# Output ARNs cho CloudFront
# QUAN TRỌNG: Luôn dùng data source ARN để GIỮ ASSOCIATION khi plan
# Logic:
# - Data source ARN: ARN hiện tại trong AWS (luôn có giá trị cụ thể, không phải "known after apply")
# - Resource ARN: ARN mới khi code thay đổi và được apply (có thể là "known after apply" khi plan)
# 
# Khi plan:
# - Nếu code thay đổi: resource qualified_arn là "known after apply"
#   → Dùng data source ARN (version hiện tại) → GIỮ ASSOCIATION
#
# Khi apply:
# - Resource sẽ publish version mới
# - Trong lần plan tiếp theo: data source sẽ lấy version mới từ AWS
#   → Terraform sẽ thấy data source ARN (version mới) khác với CloudFront ARN (version cũ)
#   → UPDATE CloudFront với version mới
#
# Output với try() để handle khi functions chưa tồn tại (tạo mới lần đầu)
# Logic:
# - Nếu function đã tồn tại: dùng data source ARN (version hiện tại) → giữ association khi plan
# - Nếu function chưa tồn tại: dùng resource qualified_arn (có thể "known after apply") → OK cho first apply
# 
# Khi plan lần đầu (functions chưa có):
# - Data source sẽ fail → try() fallback về resource ARN → OK, sẽ tạo mới
#
# Khi plan lần sau (functions đã có):
# - Data source sẽ có ARN → dùng data source ARN → giữ association khi code thay đổi
output "lambda_edge_arns_marker" {
  description = "Lambda@Edge function ARNs for CloudFront (Marker-based)"
  value = var.enable_lambda_edge ? {
    for k in keys(aws_lambda_function.edge_function_versions_marker) : k => 
      try(
        data.aws_lambda_function.existing_edge_functions[k].qualified_arn,
        aws_lambda_function.edge_function_versions_marker[k].qualified_arn
      )
  } : {}
}
