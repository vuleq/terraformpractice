terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9.0, < 5.100.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Owner       = var.owner
      Application = var.application
      Environment = var.environment
    }
  }
}

# Provider cho us-east-1 (required cho Lambda@Edge)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
  default_tags {
    tags = {
      Owner       = var.owner
      Application = var.application
      Environment = var.environment
    }
  }
}

# module "lambda_roles" {
#   for_each = var.lambda_definitions

#   source = "../../modules/iam_role_lambda" 
#   # name   = "${each.key}_role"
#   name = "prod-wdr-maritimeapps-deploy-iam-role-${each.key}"
#   s3_bucket_arns = ["arn:aws:s3:::${each.value.s3_bucket}"]
# }

module "error_codes_layer_v35" {
  source              = "../../modules/lambda_layer"
  layer_name          = "prod-wdr-maritimeApps-error-codes-layer"
  compatible_runtimes = ["nodejs22.x"]
  s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
  s3_key              = "layers/release2.0/wdr-error-codes-layer.zip"
  description         = "error-codes-layer MVP2.0"
  layer_version       = "v35"  # latest version in MVP2.0
  skip_destroy        = true
  filename            = "dummy.zip" # to avoid linter error
}

# Layer version mới  - COMMENT LẠI - UNCOMMENT KHI CẦN DÙNG
# module "error_codes_layer_v5" {
#   source              = "../../modules/lambda_layer"
#   layer_name          = "prod-wdr-maritimeApps-error-codes-layer"
#   compatible_runtimes = ["nodejs22.x"]
#   s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#   s3_key              = "layers/wdr-error-codes-v5.zip"
#   description         = "error-codes-layer"
#   layer_version       = "v5"  # Version mới
#   skip_destroy        = true
#   filename            = "dummy.zip" # to avoid linter error
# }

# Layer version cũ (v28)
module "connect_db_layer_v35" {
  source              = "../../modules/lambda_layer"
  layer_name          = "prod-wdr-maritimeApps-connect-db-layer"
  compatible_runtimes = ["nodejs22.x"]
  s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
  s3_key              = "layers/release2.0/wdr-connect-db-layer.zip"
  description         = "connect-db-layer MVP2.0"
  layer_version       = "v35"  # latest version in MVP2.0
  skip_destroy        = true
  filename            = "dummy.zip"
}


# module "connect_db_layer_v5" {
#   source              = "../../modules/lambda_layer"
#   layer_name          = "prod-wdr-maritimeApps-connect-db-layer"
#   compatible_runtimes = ["nodejs22.x"]
#   s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#   s3_key              = "layers/wdr-connect-db-v5.zip"  
#   description         = "connect-db-layer"
#   layer_version       = "v5"  # Version mới
#   skip_destroy        = true
#   filename            = "dummy.zip"
# }



module "models_layer_v35" {
  source              = "../../modules/lambda_layer"
  layer_name          = "prod-wdr-maritimeApps-models-layer"
  compatible_runtimes = ["nodejs22.x"]
  s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
  s3_key              = "layers/release2.0/wdr-models-layer.zip"
  description         = "models-layer MVP2.0"
  layer_version       = "v35"  # latest version in MVP2.0
  skip_destroy        = true
  filename            = "dummy.zip"
}


# module "models_layer_v5" {
#   source              = "../../modules/lambda_layer"
#   layer_name          = "prod-wdr-maritimeApps-models-layer"
#   compatible_runtimes = ["nodejs22.x"]
#   s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#   s3_key              = "layers/wdr-models-v5.zip"
#   description         = "models-layer"
#   layer_version       = "v5"  # Version mới
#   skip_destroy        = true
#   filename            = "dummy.zip"
# }

module "sharp_layer" {
  source              = "../../modules/lambda_layer"
  layer_name          = "prod-wdr-maritimeApps-sharp-layer"
  compatible_runtimes = ["nodejs22.x"]
  s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
  s3_key              = "layers/sharp-lib-v1.zip"
  description         = "sharp-layer"
  filename            = "dummy.zip"
}

module "exceljs_layer" {
  source              = "../../modules/lambda_layer"
  layer_name          = "prod-wdr-maritimeApps-exceljs-layer"
  compatible_runtimes = ["nodejs22.x"]
  s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
  # s3_key              = "layers/wdr-exceljs-layer-v1.zip"
  s3_key              = "layers/release2.0/wdr-excel-js-layer.zip"
  description         = "exceljs-layer"
  filename            = "dummy.zip"
}

# layer to import data 
module "csv_parse_layer" {
  source              = "../../modules/lambda_layer"
  layer_name          = "prod-wdr-maritimeApps-csv-parse-layer"
  compatible_runtimes = ["nodejs22.x"]
  s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
  s3_key              = "layers/wdr-csv-parse-layer-v1.zip"
  description         = "csv-parse-layer"
  filename            = "dummy.zip"
}

module "response_model_layer" {
  source              = "../../modules/lambda_layer"
  layer_name          = "prod-wdr-maritimeApps-response-model-layer"
  compatible_runtimes = ["nodejs22.x"]
  s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
  s3_key              = "layers/prod-wdr-MaritimeApps-lambda-response-model.zip"
  description         = "response-model-layer"
  filename            = "dummy.zip"
}

module "common_utils_layer" {
  source              = "../../modules/lambda_layer"
  layer_name          = "prod-wdr-maritimeApps-common-utils-layer"
  compatible_runtimes = ["nodejs22.x"]
  s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
  s3_key              = "layers/release2.0/wdr-common-utils-layer.zip"
  description         = "common-utils-layer MVP2.0" # latest version in MVP2.0
  filename            = "dummy.zip"
}

module "pdf_utils_layer" {
  source              = "../../modules/lambda_layer"
  layer_name          = "prod-wdr-maritimeApps-pdf-utils-layer"
  compatible_runtimes = ["nodejs22.x"]
  s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
  s3_key              = "layers/release2.0/wdr-pdf-utils-layer.zip"
  description         = "pdf-utils-layer MVP2.0" # latest version in MVP2.0
  filename            = "dummy.zip"
}

# module "pdf_utils_layer_v24" {
#   source              = "../../modules/lambda_layer"
#   layer_name          = "prod-wdr-maritimeApps-pdf-utils-layer"
#   compatible_runtimes = ["nodejs22.x"]
#   s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
#   s3_key              = "layers/wdr-pdf-utils-layer-v24.zip"
#   description         = "pdf-utils-layer MVP2.0"
#   layer_version       = "v24"  # Version mới
#   skip_destroy        = true
#   filename            = "dummy.zip"
# }

module "connect_external_layer" {
  source              = "../../modules/lambda_layer"
  layer_name          = "prod-wdr-maritimeApps-connect-external-layer"
  compatible_runtimes = ["nodejs22.x"]
  s3_bucket           = "prod-wdr-maritimeapps-deploy-store-lambdasources"
  s3_key              = "layers/release2.0/wdr-connect-external-layer.zip"
  description         = "connect-external-layer MVP2.0"
  layer_version       = "v1"  # latest version in MVP2.0
  skip_destroy        = true
  filename            = "dummy.zip"
}
# # added to haveave latest update for Lambda
# resource "random_id" "lambda_trigger" {
#   byte_length = 8
# }

# Tạo map các layer ARNs với versioning
locals {
  available_layers = {
    "AWS-Parameters-and-Secrets-Lambda-Extension" = "arn:aws:lambda:us-east-2:590474943231:layer:AWS-Parameters-and-Secrets-Lambda-Extension:19"
    "chrome-aws-lambda" = "arn:aws:lambda:us-east-2:764866452798:layer:chrome-aws-lambda:50"
      
    "connect_db_v35"      = module.connect_db_layer_v35.layer_arn_latest          
    "error_codes_v35" = module.error_codes_layer_v35.layer_arn_latest      
    "models_v35"      = module.models_layer_v35.layer_arn_latest    
    "pdf_utils_layer" = module.pdf_utils_layer.layer_arn_latest
    
    
    # Other layers
    "sharp"           = module.sharp_layer.layer_arn_latest
    "exceljs"         = module.exceljs_layer.layer_arn_latest
    "csv_parse"       = module.csv_parse_layer.layer_arn_latest
    "response_model"  = module.response_model_layer.layer_arn_latest # remove in next release
    "common_utils"    = module.common_utils_layer.layer_arn_latest
    "connect_external"    = module.connect_external_layer.layer_arn_latest
  }
}

module "lambda_functions" {
  for_each = var.lambda_definitions
  source           = "../../modules/lambda_functions"
  function_name    = each.value.function_name
  runtime          = each.value.runtime
  handler          = each.value.handler
  timeout          = each.value.timeout
  memory_size      = each.value.memory_size
  role_arn         = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
  
  s3_bucket        = try(each.value.s3_bucket, null)
  s3_key           = try(each.value.s3_key, null)
  dummy_code_bucket = var.dummy_lambda_code_bucket  # Dummy code bucket for infra-only Lambda creation
  dummy_code_key    = var.dummy_lambda_code_key      # Dummy code key (e.g., "dummy/lambda-placeholder.zip")
  
  # Source code hash: Auto-calculate from S3 if available, otherwise use dummy code hash
  # Priority: 1. Manual hash > 2. Real code ETag > 3. Dummy code ETag
  source_code_hash = each.value.source_code_hash != null ? each.value.source_code_hash : (
    try(each.value.s3_key, null) != null && contains(keys(data.aws_s3_object.lambda_zip), each.key) ? data.aws_s3_object.lambda_zip[each.key].etag : (
      try(var.dummy_lambda_code_key, null) != null && length(data.aws_s3_object.dummy_lambda_code) > 0 ? data.aws_s3_object.dummy_lambda_code[0].etag : null
    )
  )
  

  environment = merge({
    DB_SECRET_ARN = "arn:aws:secretsmanager:us-east-2:797233058645:secret:prod-wdr-maritimeapps-secretmanager-tmaprod-93zYv3"
    DB_HOST     = module.core_resources.rds_cluster_endpoint["wdr"] 
    SQS_QUEUE_URL = try(module.core_resources.sqs_queue_urls["notification_processing"], "")
    SQS_SILENT_URL = try(module.core_resources.sqs_queue_urls["silent_notification_processing"], "")
    PROJECT_TASKS_QUEUE_URL = try(module.core_resources.sqs_queue_urls["project_tasks"], "")
    LOG_LEVEL = "ERROR"
    JWT_SECRET = "wdr-default-secret-key"
  }, each.value.env_vars,
  # WebSocket API Gateway endpoint (https://) - chỉ set cho lambda_130 nếu chưa có trong env_vars
  each.key == "lambda_130" && !contains(keys(each.value.env_vars), "WEBSOCKET_ENDPOINT") ? {
    WEBSOCKET_ENDPOINT = try(module.websocket_api_gw["websocket_api_1"].websocket_connections_base_url, "")
  } : {},
  
  {})  
  # Sử dụng layer tùy chọn dựa trên tên layer được chỉ định
  layers = [for layer_name in each.value.layers : local.available_layers[layer_name] if contains(keys(local.available_layers), layer_name) && local.available_layers[layer_name] != null]
  # vpc_config = null
  vpc_config = var.vpc_config
  
}


data "aws_s3_object" "lambda_zip" {
  for_each = {
    for k, v in var.lambda_definitions : k => v
    if try(v.s3_bucket, null) != null && try(v.s3_key, null) != null
  }
  bucket   = each.value.s3_bucket
  key      = each.value.s3_key
}

# Data source để lấy ETag của dummy Lambda code (dùng khi tạo Lambda mới không có code)
data "aws_s3_object" "dummy_lambda_code" {
  count  = var.dummy_lambda_code_bucket != null && var.dummy_lambda_code_key != null ? 1 : 0
  bucket = var.dummy_lambda_code_bucket
  key    = var.dummy_lambda_code_key
}

locals {
  lambda_functions_map = {
    for k, mod in module.lambda_functions :
    k => {
      arn           = mod.arn
      function_name = mod.function_name
      invoke_arn    = mod.invoke_arn
    }
  }
  
  # Map từ function_name -> ARN (để dùng trong state machine definition)
  lambda_function_name_to_arn = {
    for k, v in local.lambda_functions_map : v.function_name => v.arn
  }
}

locals {
  processed_api_paths = {
    for path_key, path in var.api_paths : path_key => {
      parent_path           = path.parent_path
      child_path            = path.child_path
      grandchild_path       = path.grandchild_path
      great_grandchild_path = try(path.great_grandchild_path, "")
      http_methods = [
        for method in path.http_methods : {
          method           = method.method
          lambda_key       = method.lambda_key
          enable_auth       = try(method.enable_auth, true)  # Default: true nếu không có
          request_template = (
            try(method.template_file, null) != null && trimspace(method.template_file) != "" ?
            file("${path.module}/${method.template_file}") : null
          )
        }
      ]
    }
  }
}

module "rest_api_gw" {
  for_each = var.apis

  source           = "../../modules/module_rest_api_gw"
  api_name         = each.value.api_name
  environment      = var.environment
  aws_region       = var.region
  api_paths        = each.value.api_paths
  lambda_functions = local.lambda_functions_map
  cognito_user_pool_arn = var.cognito_user_pool_arn
  enable_cognito_auth   = var.enable_cognito_auth
  
}

module "websocket_api_gw" {
  for_each = var.websocket_apis

  source                = "../../modules/module_websocket_api_gw"
  api_name              = each.value.api_name
  environment           = var.environment
  aws_region            = var.region
  lambda_functions      = local.lambda_functions_map
  connect_lambda_key    = each.value.connect_lambda_key
  disconnect_lambda_key = each.value.disconnect_lambda_key
  route_selection_expression = each.value.route_selection_expression
  stage_name            = each.value.stage_name
  enable_access_logs    = try(each.value.enable_access_logs, false)  # Default: true cho production

}

locals {
  cloudfront_distributions = merge(
    {
      fe_site = {
        origin_domain_name = var.fe_bucket_domain_name
        origin_type        = "s3"
        name               = "Prod WDR Frontend Distribution"
        # S3 Assets bucket domain cho /s3assets/* path pattern
        s3_assets_bucket_domain = "${var.s3_buckets.bucket1.name}.s3.us-east-2.amazonaws.com"
        # Lambda@Edge functions được associate tự động trong cloudfront.tf dựa trên pattern matching
        # Không cần khai báo ở đây vì cloudfront.tf sẽ tự tìm function có key chứa "FE"
      }
    },
    {
      for k, v in module.rest_api_gw :
      "be_site_${k}" => {
        origin_domain_name = v.api_domain_name
        origin_path        = v.api_origin_path
        origin_type        = "api_gateway"
        name               = "WDR Backend API Distribution - ${k}"
        # Lambda@Edge functions được associate tự động trong cloudfront.tf dựa trên pattern matching
        # Không cần khai báo ở đây vì cloudfront.tf sẽ tự tìm function có key chứa "BE"
      }
    }
  )
}


module "cloudfront" {
  source = "../../modules/module_cloudfront"
  cloudfront_distributions = local.cloudfront_distributions
  enable_cognito_proxy = var.cognito_proxy_distribution.enabled
  enable_oac_for_fe = var.enable_oac_for_fe
  enable_lambda_edge = false  # Enable Lambda@Edge functions creation
  
  # Lambda@Edge function names - CẦN THIẾT để tạo Lambda@Edge functions trong us-east-1
  lambda_edge_function_names = {
    "prod-wdr-lambda-edge-FE-new" = {
      runtime     = "nodejs22.x"
      timeout     = 5
      memory_size = 128
    }
    "prod-wdr-lambda-edge-BE-new" = {
      runtime     = "nodejs22.x"
      timeout     = 5
      memory_size = 128
    }
  }
  
  # Marker-based replacement variables
  cors_origins = var.cors_origins
  csp_config   = var.csp_config
  
  # Lambda@Edge IAM Role ARN - Sử dụng role có sẵn
  lambda_edge_role_arn = var.lambda_edge_role_arn
  
  # Tags
  owner       = var.owner
  application = var.application
  environment = var.environment
  
  # Providers cho Lambda@Edge (phải deploy ở us-east-1)
  # Cần uncomment để Terraform có thể quản lý resources đã tồn tại trong state
  # Ngay cả khi enable_lambda_edge = false, vẫn cần provider để destroy resources cũ
  providers = {
    aws.us_east_1 = aws.us_east_1
  }
}

module "core_resources" {
  source        = "../../modules/module_sqs_s3_db"
  region        = var.region
  environment   = var.environment
  s3_buckets    = var.s3_buckets
  rds_instances = var.rds_instances
  rds_clusters  = var.rds_clusters
  lambda_zips   = var.lambda_zips
  lambda_functions = local.lambda_functions_map
  sqs_queues    = var.sqs_queues
  db_subnet_group_name = var.db_subnet_group_name
  db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
  # cloudfront_oai_id = module.cloudfront.origin_access_identity_ids["fe_site"]  # Comment lại tạm thời để tránh lỗi permission
}

# Local để tạo lambda ARN mapping cho state machines
# Map từ lambda_key (lambda_185) hoặc function_name sang ARN
locals {
  # Map từ lambda_key -> ARN
  lambda_key_to_arn = {
    for k, v in local.lambda_functions_map : k => v.arn
  }
  
  # Map từ function_name -> ARN
  lambda_name_to_arn = {
    for k, v in local.lambda_functions_map : v.function_name => v.arn
  }
  
  # Combine cả hai mappings
  lambda_arn_mapping_all = merge(
    local.lambda_key_to_arn,
    local.lambda_name_to_arn
  )
}

# CloudWatch Log Group cho State Machine
# Tự động tạo log group nếu enable_logging = true và chưa có log_group_arn
# PHẢI ĐỊNH NGHĨA TRƯỚC local.state_machine_log_group_arn_map để reference được
resource "aws_cloudwatch_log_group" "state_machine_logs" {
  for_each = {
    for k, v in var.state_machines : k => v
    if try(v.enable_logging, false) && try(v.log_group_arn, null) == null
  }
  
  name              = "/aws/lambda/${each.value.state_machine_name}"
  retention_in_days = 30  # Giữ logs 30 ngày (có thể điều chỉnh)
  
  tags = merge(
    {
      Name        = "${each.value.state_machine_name}-logs"
      Environment = var.environment
      Purpose     = "State Machine Execution Logs"
    },
    try(each.value.additional_tags, {})
  )
}

# Local để map log group ARN cho state machines
# Nếu enable_logging = true:
#   - Nếu có log_group_arn trong config → dùng log_group_arn đó (đảm bảo có suffix :*)
#   - Nếu không có log_group_arn → dùng ARN từ resource vừa tạo và thêm suffix :*
# LƯU Ý: AWS Step Functions yêu cầu log group ARN phải có suffix :* để có thể ghi logs
locals {
  state_machine_log_group_arn_map = {
    for k, v in var.state_machines : k => (
      try(v.enable_logging, false) ? (
        # Lấy ARN (từ config hoặc từ resource)
        try(v.log_group_arn, null) != null ? (
          # Nếu có log_group_arn trong config, kiểm tra xem đã có :* chưa
          endswith(try(v.log_group_arn, ""), ":*") ? v.log_group_arn : "${v.log_group_arn}:*"
        ) : (
          # Nếu không có, dùng ARN từ resource vừa tạo và thêm :*
          try(aws_cloudwatch_log_group.state_machine_logs[k].arn, null) != null ? "${aws_cloudwatch_log_group.state_machine_logs[k].arn}:*" : null
        )
      ) : null
    )
  }
}

# Step Functions State Machines
# Hỗ trợ tự động lấy ARN từ lambda functions
module "state_machines" {
  for_each = var.state_machines
  
  source = "../../modules/module_state_machine"
  
  state_machine_name = each.value.state_machine_name
  
  # Priority: definition_file > template_file > definition_json
  definition_file = try(each.value.definition_file, null)
  definition_json = (
    # Nếu có definition_file, không dùng definition_json
    try(each.value.definition_file, null) != null ? null : (
      # Nếu có template_file, render template với ARN từ lambda functions
      try(each.value.template_file, null) != null ? (
        templatefile(
          "${path.module}/${each.value.template_file}",
          {
            export_metadata_arn    = try(local.lambda_name_to_arn["prod-wdr-mapps-project-export-metadata"], "arn:aws:lambda:${var.region}:${var.account_id}:function:prod-wdr-mapps-project-export-metadata")
            export_joblist_arn     = try(local.lambda_name_to_arn["prod-wdr-mapps-project-export-joblist"], "arn:aws:lambda:${var.region}:${var.account_id}:function:prod-wdr-mapps-project-export-joblist")
            get_jobs_arn           = try(local.lambda_name_to_arn["prod-wdr-mapps-project-get-jobs-for-export"], "arn:aws:lambda:${var.region}:${var.account_id}:function:prod-wdr-mapps-project-get-jobs-for-export")
            copy_job_resource_arn   = try(local.lambda_name_to_arn["prod-wdr-mapps-project-copy-job-export-resource"], "arn:aws:lambda:${var.region}:${var.account_id}:function:prod-wdr-mapps-project-copy-job-export-resource")
            pdf_generator_arn      = try(local.lambda_name_to_arn["prod-wdr-mapps-pdf-generator"], "arn:aws:lambda:${var.region}:${var.account_id}:function:prod-wdr-mapps-pdf-generator")
            combine_exports_arn    = try(local.lambda_name_to_arn["prod-wdr-mapps-project-combine-exports"], "arn:aws:lambda:${var.region}:${var.account_id}:function:prod-wdr-mapps-project-combine-exports")
            update_database_arn    = try(local.lambda_name_to_arn["prod-wdr-mapps-project-update-database"], "arn:aws:lambda:${var.region}:${var.account_id}:function:prod-wdr-mapps-project-update-database")
            export_notification_arn = try(local.lambda_name_to_arn["prod-wdr-mapps-project-export-notification"], "arn:aws:lambda:${var.region}:${var.account_id}:function:prod-wdr-mapps-project-export-notification")
          }
        )
      ) : (
        # Fallback về definition_json nếu có
        try(each.value.definition_json, null)
      )
    )
  )
  
  # Merge user-provided mapping với auto-generated mapping từ lambda functions
  lambda_arn_mapping = merge(
    local.lambda_arn_mapping_all,
    try(each.value.lambda_arn_mapping, {})
  )
  account_id         = var.account_id
  region             = var.region
  environment        = var.environment
  existing_role_arn  = try(each.value.existing_role_arn, null)
  iam_policy_statements = try(each.value.iam_policy_statements, [])
  enable_logging     = try(each.value.enable_logging, false)
  # Sử dụng log group ARN từ resource nếu có, nếu không thì dùng từ variable
  log_group_arn      = try(local.state_machine_log_group_arn_map[each.key], try(each.value.log_group_arn, null))
  include_execution_data = try(each.value.include_execution_data, true)
  log_level          = try(each.value.log_level, "ALL")
  enable_tracing     = try(each.value.enable_tracing, false)
  additional_tags    = try(each.value.additional_tags, {})
}

# Local để map state machine name -> ARN (để dùng trong lambda env vars)
# LƯU Ý: Không dùng trong lambda environment để tránh circular dependency
# User cần set ARN đầy đủ trong infra.tfvars sau khi state machine được tạo
locals {
  state_machine_arn_map = {
    for k, mod in module.state_machines :
    mod.state_machine_name => mod.state_machine_arn
  }
}

# S3 notifications đã được chuyển sang file s3_notifications.tf để dễ quản lý

# # =============================================================================
# # EventBridge Schedulers Configuration
# # =============================================================================
# 
# # Schedule group name - Dùng chung cho tất cả schedulers
# locals {
#   shared_schedule_group_name = "prod-wdr-maritimeapps-schedulers"
# }
# 
# # SCHEDULER 1: Project Daily Fetch - 6:00 AM UTC+8 (Singapore time)
# # Scheduler này quản lý schedule group (đã có sẵn trong state)
# module "project_daily_fetch_scheduler" {
#   source = "../../modules/module_eventbridge_scheduler"
# 
#   scheduler_name                = "prod-wdr-maritimeapps-project-daily-fetch-scheduler"
#   scheduler_group_name          = local.shared_schedule_group_name
#   create_schedule_group         = true  # Scheduler đầu tiên quản lý schedule group
#   target_lambda_arn            = module.lambda_functions["lambda_79"].arn
#   target_lambda_function_name  = module.lambda_functions["lambda_79"].function_name
#   environment                  = var.environment
#   
#   # Sử dụng existing IAM role (cần update trust policy để include scheduler.amazonaws.com)
#   existing_role_arn            = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
#   
#   
#   # Schedule: 6:00 AM UTC+8 (Singapore time) = 22:00 UTC
#   schedule_expression = "cron(0 7 * * ? *)"
#   
#   # Input payload cho Lambda function
#   lambda_input = {
#     trigger_source = "daily_scheduler"
#     schedule_time  = "6:00 AM UTC+8"
#     environment    = var.environment
#     task_type     = "project_daily_fetch"
#   }
#   
#   # Cấu hình retry
#   max_retry_attempts = 3
#   max_event_age      = 3600  # 1 hour
#   
#   # Enable/disable scheduler
#   enabled = true
# 
#   depends_on = [
#     module.lambda_functions
#   ]
# }
# 
# # =============================================================================
# # SCHEDULER 2: Daily Schedule - Report Update Silent Notification (Uncomment and configure as needed)
# # =============================================================================
# 
# module "report_update_silent_notification_scheduler" {
#   source = "../../modules/module_eventbridge_scheduler"
# 
#   scheduler_name                = "prod-wdr-mapps-report-update-silent-noti-scheduler"
#   scheduler_group_name          = local.shared_schedule_group_name
#   create_schedule_group         = false  # Dùng schedule group có sẵn
#   target_lambda_arn            = module.lambda_functions["lambda_161"].arn  # Thay lambda_XX bằng lambda key thực tế
#   target_lambda_function_name  = module.lambda_functions["lambda_161"].function_name
#   environment                  = var.environment
#   
#   # Sử dụng existing IAM role (cần update trust policy để include scheduler.amazonaws.com)
#   existing_role_arn            = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
#   
#   # Schedule: Thay đổi theo nhu cầu (ví dụ: 8:00 AM UTC+8 = 0:00 UTC)
#   schedule_expression = "rate(60 minutes)"
#   
#   # Input payload cho Lambda function
#   lambda_input = {
#     trigger_source = "report_update_silent_notification_scheduler"
#     environment    = var.environment
#     task_type     = "report_update_silent_notification"
#   }
#   
#   # Cấu hình retry
#   max_retry_attempts = 3
#   max_event_age      = 3600  # 1 hour
#   
#   # Enable/disable scheduler
#   enabled = true
# 
#   depends_on = [
#     module.lambda_functions
#   ]
# }
# 
# 
# # =============================================================================
# # SCHEDULER 3: Daily Schedule - Lock Dormant Users (Commented out - Uncomment if needed)
# # =============================================================================
# 
# module "lock_dormant_users_scheduler" {
#   source = "../../modules/module_eventbridge_scheduler"
# 
#   scheduler_name                = "prod-wdr-maritimeapps-lock-dormant-users-scheduler"
#   scheduler_group_name          = local.shared_schedule_group_name
#   create_schedule_group         = false
#   target_lambda_arn            = module.lambda_functions["lambda_162"].arn  # Replace with actual lambda
#   target_lambda_function_name  = module.lambda_functions["lambda_162"].function_name
#   environment                  = var.environment
#   
#   # Sử dụng existing IAM role thay vì tạo mới (đã có đầy đủ permissions)
#   existing_role_arn            = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
#   
#   # Schedule: Every Monday at 8:00 AM UTC+8 = 0:00 AM UTC
#   schedule_expression = "cron(0 0 * * ? *)"
#   
#   lambda_input = {
#     trigger_source = "lock_dormant_users_scheduler"
#     environment    = var.environment
#     task_type     = "lock_dormant_users"
#   }
#   
#   max_retry_attempts = 3
#   max_event_age      = 3600
#   enabled = true
# 
#   depends_on = [
#     module.lambda_functions
#   ]
# }
# 
# # =============================================================================
# # SCHEDULER 4:  Rate Schedule - Lambda Ping Schedule (Commented out - Uncomment if needed)
# # =============================================================================
# 
# module "lambda_ping_schedule_scheduler" {
#   source = "../../modules/module_eventbridge_scheduler"
# 
#   scheduler_name                = "prod-wdr-maritimeapps-lambda-ping-schedule-scheduler"
#   scheduler_group_name          = local.shared_schedule_group_name
#   create_schedule_group         = false
#   target_lambda_arn            = module.lambda_functions["lambda_163"].arn  # Replace with actual lambda
#   target_lambda_function_name  = module.lambda_functions["lambda_163"].function_name
#   environment                  = var.environment
#   
#   # Sử dụng existing IAM role thay vì tạo mới (đã có đầy đủ permissions)
#   existing_role_arn            = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
#   
#   # Schedule: Every 5 minutes
#   schedule_expression = "rate(5 minutes)"
#   
#   lambda_input = {
#     trigger_source = "lambda_ping_schedule_scheduler"
#     environment    = var.environment
#     task_type     = "lambda-ping-schedule"
#   }
#   
#   max_retry_attempts = 3
#   max_event_age      = 3600
#   enabled = true
# 
#   depends_on = [
#     module.lambda_functions
#   ]
# }
# 
# # =============================================================================
# # SCHEDULER 5: Daily Schedule - Multi Cognito Auto Sync Schedule (Commented out - Uncomment if needed)
# # =============================================================================
# 
# module "multi_cognito_auto_sync_schedule_scheduler" {
#   source = "../../modules/module_eventbridge_scheduler"
# 
#   scheduler_name                = "prod-wdr-maritimeapps-multi-cognito-auto-sync-schedule"
#   scheduler_group_name          = local.shared_schedule_group_name
#   create_schedule_group         = false
#   target_lambda_arn            = module.lambda_functions["lambda_175"].arn  # Replace with actual lambda
#   target_lambda_function_name  = module.lambda_functions["lambda_175"].function_name
#   environment                  = var.environment
#   
#   # Sử dụng existing IAM role thay vì tạo mới (đã có đầy đủ permissions)
#   existing_role_arn            = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
#   
#   # Schedule: Every Monday at 8:00 AM UTC+8 = 0:00 AM UTC
#   schedule_expression = "cron(0 0 * * ? *)"
#   
#   lambda_input = {
#     trigger_source = "multi_cognito_auto_sync_schedule_scheduler"
#     environment    = var.environment
#     task_type     = "multi-cognito-auto-sync"
#   }
#   
#   max_retry_attempts = 3
#   max_event_age      = 3600
#   enabled = true
# 
#   depends_on = [
#     module.lambda_functions
#   ]
# }
# 
# # =============================================================================
# # SCHEDULER 6: Daily Schedule - Cleanup-old-records
# # =============================================================================
# 
# module "cleanup_old_records_scheduler" {
#   source = "../../modules/module_eventbridge_scheduler"
# 
#   scheduler_name                = "prod-wdr-maritimeapps-cleanup-old-records-schedule"
#   scheduler_group_name          = local.shared_schedule_group_name
#   create_schedule_group         = false
#   target_lambda_arn            = module.lambda_functions["lambda_193"].arn  # Replace with actual lambda
#   target_lambda_function_name  = module.lambda_functions["lambda_193"].function_name
#   environment                  = var.environment
#   
#   # Sử dụng existing IAM role thay vì tạo mới (đã có đầy đủ permissions)
#   existing_role_arn            = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
#   
#   # Schedule: Every Monday at 8:00 AM UTC+8 = 0:00 AM UTC
#   schedule_expression = "cron(0 0 * * ? *)"
#   
#   lambda_input = {
#     trigger_source = "cleanup_old_records_scheduler"
#     environment    = var.environment
#     task_type     = "cleanup-old-records"
#   }
#   
#   max_retry_attempts = 3
#   max_event_age      = 3600
#   enabled = true
# 
#   depends_on = [
#     module.lambda_functions
#   ]
# }
# 
# # =============================================================================
# # SCHEDULER 7: Daily Schedule - Silent Notification Schedule
# # =============================================================================
# 
# module "silent_notification_schedule_scheduler" {
#   source = "../../modules/module_eventbridge_scheduler"
# 
#   scheduler_name                = "prod-wdr-maritimeapps-changes-silent-noti-schedule"
#   scheduler_group_name          = local.shared_schedule_group_name
#   create_schedule_group         = false
#   target_lambda_arn            = module.lambda_functions["lambda_172"].arn  # Replace with actual lambda
#   target_lambda_function_name  = module.lambda_functions["lambda_172"].function_name
#   environment                  = var.environment
#   
#   # Sử dụng existing IAM role thay vì tạo mới (đã có đầy đủ permissions)
#   existing_role_arn            = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
#   
#   # Schedule: Every Monday at 8:00 AM UTC+8 = 0:00 AM UTC
#   schedule_expression = "cron(0 0 * * ? *)"
#   
#   lambda_input = {
#     trigger_source = "changes_update_silent_notification_scheduler"
#     environment    = var.environment
#     task_type     = "changes_update_silent_notification"
#   }
#   
#   max_retry_attempts = 3
#   max_event_age      = 3600
#   enabled = true
# 
#   depends_on = [
#     module.lambda_functions
#   ]
# }
# 
# # =============================================================================
# # SCHEDULER 8: Daily Schedule - Summarize Usage Analytics
# # =============================================================================
# 
# module "summarize_usage_analytics_scheduler" {
#   source = "../../modules/module_eventbridge_scheduler"
# 
#   scheduler_name                = "prod-wdr-maritimeapps-summarize-usage-analytics-schedule"
#   scheduler_group_name          = local.shared_schedule_group_name
#   create_schedule_group         = false
#   target_lambda_arn            = module.lambda_functions["lambda_199"].arn  # Replace with actual lambda
#   target_lambda_function_name  = module.lambda_functions["lambda_199"].function_name
#   environment                  = var.environment
#   
#   # Sử dụng existing IAM role thay vì tạo mới (đã có đầy đủ permissions)
#   existing_role_arn            = "arn:aws:iam::797233058645:role/prod_wdr_maritimeapps_deploy_app_lambda"
#   
#   # Schedule: Every Monday at 8:00 AM UTC+8 = 0:00 AM UTC
#   schedule_expression = "cron(0 0 * * ? *)"
#   
#   lambda_input = {
#     trigger_source = "summarize_usage_analytics_scheduler"
#     environment    = var.environment
#     task_type     = "summarize_usage_analytics"
#   }
#   
#   max_retry_attempts = 3
#   max_event_age      = 3600
#   enabled = true
# 
#   depends_on = [
#     module.lambda_functions
#   ]
# }