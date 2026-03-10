resource "aws_lambda_function" "this" {
  function_name = var.function_name
  runtime       = var.runtime
  handler       = var.handler
  timeout       = var.timeout
  memory_size   = var.memory_size
  # role          = var.role_arn   #thay doi bang cach input arn cua iam vao day: arn:aws:iam::ACCOUNT_ID:role/LAMBDA_ROLE_NAME
  role          = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"

  s3_bucket         = coalesce(var.s3_bucket, var.dummy_code_bucket)
  s3_key            = coalesce(var.s3_key, var.dummy_code_key)
  source_code_hash  = var.source_code_hash

  layers = var.layers

  environment {
    variables = merge(var.environment, {
      # DB_SECRET_ARN = var.environment["DB_SECRET_ARN"] // Đã xóa
    })
  }

  # VPC Configuration
  dynamic "vpc_config" {
    for_each = var.vpc_config != null ? [var.vpc_config] : []
    content {
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.security_group_ids
    }
  }

  # tags = {
  #   Name = "${var.owner}_${var.application}_${var.environment}"
  # }

  # Lifecycle rules:
  # - ignore_changes last_modified: Fix for AWS provider bug
  # - ignore_changes source_code_hash: Allow CICD to update Lambda code separately from infra
  #   Terraform will manage infra (config, env vars, etc.), CICD will manage code updates
  lifecycle {
    ignore_changes = [
      last_modified,
      source_code_hash,  # CICD will handle code updates separately
      s3_key,            # CICD manages S3 key paths
      layers,            # CICD pipeline manages layer assignments after creation
    ]
  }
}




