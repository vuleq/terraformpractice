# Tạo Lambda Layer với versioning
resource "aws_lambda_layer_version" "this" {
  count = var.create_layer ? 1 : 0
  
  layer_name          = var.layer_name
  compatible_runtimes = var.compatible_runtimes
  s3_bucket           = var.s3_bucket
  s3_key              = local.actual_s3_key
  description         = "${var.description} (Version: ${var.layer_version})"
  source_code_hash    = var.create_layer ? data.aws_s3_object.layer_zip[0].etag : null
  skip_destroy        = var.skip_destroy

  # Ignore changes để CICD có thể update code và publish version mới
  # Terraform sẽ detect latest version từ data source và update Lambda functions
  lifecycle {
    # Mặc định: Luôn cho phép CICD update code
    ignore_changes = [source_code_hash, s3_key]
    
    # Optional: Uncomment nếu muốn Terraform quản lý code (không cho CICD update)
    # Nếu uncomment, cần uncomment variable cicd_managed_code ở variables.tf
    # ignore_changes = var.cicd_managed_code ? [source_code_hash, s3_key] : []
  }
}

# Data source để tạo hash từ S3 object (chỉ cần khi create_layer = true)
# Nếu có dummy_s3_key, dùng dummy.zip; nếu không, dùng s3_key (file thật)
# Lưu ý: Cần đảm bảo dummy.zip đã có trong S3 tại path dummy_s3_key
locals {
  # Quyết định dùng file nào: ưu tiên dummy_s3_key (có default trong variable), nếu không thì dùng s3_key
  # Khi tạo mới layer, sẽ tự động dùng dummy.zip từ S3
  actual_s3_key = var.dummy_s3_key != null ? var.dummy_s3_key : var.s3_key
}

# Chỉ cần data source khi create_layer = true
data "aws_s3_object" "layer_zip" {
  count  = var.create_layer ? 1 : 0
  bucket = var.s3_bucket
  key    = local.actual_s3_key
}

# Data source để lấy current region
data "aws_region" "current" {}

# Query latest layer version từ AWS Lambda API
# Mỗi khi chạy terraform plan/apply, sẽ query latest version từ AWS
# Điều này cho phép Lambda functions tự động update khi có layer version mới
# Hỗ trợ cả Windows (PowerShell) và Mac/Linux (PowerShell Core hoặc bash)
data "external" "latest_layer_version" {
  count = var.create_layer ? 1 : 0
  
  # Dùng PowerShell (có sẵn trên Windows, cần cài PowerShell Core trên Mac/Linux)
  # Hoặc có thể dùng bash trên Mac/Linux bằng cách thay "powershell" bằng "bash" và sửa command
  program = ["powershell", "-Command", <<-EOT
    $ErrorActionPreference = "Stop"
    try {
      # Query tất cả layer versions và sort theo version number để lấy latest
      $result = aws lambda list-layer-versions --layer-name ${var.layer_name} --region ${data.aws_region.current.name} --output json 2>$null
      if ($result) {
        $allVersions = $result | ConvertFrom-Json
        if ($allVersions.LayerVersions -and $allVersions.LayerVersions.Count -gt 0) {
          # Sort theo Version number (descending) và lấy version cao nhất
          $latest = $allVersions.LayerVersions | Sort-Object -Property Version -Descending | Select-Object -First 1
          if ($latest.Version -and $latest.LayerVersionArn) {
            Write-Output "{`"Version`": `"$($latest.Version)`", `"Arn`": `"$($latest.LayerVersionArn)`"}"
          } else {
            Write-Output '{"Version": "null", "Arn": "null"}'
          }
        } else {
          Write-Output '{"Version": "null", "Arn": "null"}'
        }
      } else {
        Write-Output '{"Version": "null", "Arn": "null"}'
      }
    } catch {
      Write-Output '{"Version": "null", "Arn": "null"}'
    }
  EOT
  ]
}

# Lấy latest version ARN từ AWS (không phải từ Terraform resource)
# Khi có layer version mới và chạy terraform plan/apply, sẽ tự động detect và update Lambda functions
locals {
  # Ưu tiên dùng ARN từ AWS query (latest version thực tế)
  # Nếu query không thành công, fallback về ARN từ Terraform resource
  latest_layer_arn = var.create_layer ? (
    length(data.external.latest_layer_version) > 0 && 
    try(data.external.latest_layer_version[0].result.Arn, null) != null &&
    try(data.external.latest_layer_version[0].result.Arn, "") != "" &&
    try(data.external.latest_layer_version[0].result.Arn, "") != "null" ?
    data.external.latest_layer_version[0].result.Arn :
    (length(aws_lambda_layer_version.this) > 0 ? aws_lambda_layer_version.this[0].arn : null)
  ) : null
  
  latest_version_number = var.create_layer ? (
    length(data.external.latest_layer_version) > 0 && 
    try(data.external.latest_layer_version[0].result.Version, null) != null &&
    try(data.external.latest_layer_version[0].result.Version, "") != "" &&
    try(data.external.latest_layer_version[0].result.Version, "") != "null" ?
    data.external.latest_layer_version[0].result.Version :
    (length(aws_lambda_layer_version.this) > 0 ? aws_lambda_layer_version.this[0].version : null)
  ) : null
} 