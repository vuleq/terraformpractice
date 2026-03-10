# root/env/staging/variables.tf
variable "owner" {
  description = " owner name for tag"
  type        = string
}

variable "application" {
  description = "application name tag"
  type        = string
}

variable "environment" {
  description = "environment"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {}
variable "project_name" {}

variable "lambda_edge_role_arn" {
  description = "ARN of the Lambda@Edge IAM role created by customer"
  type        = string
  default     = null
}

variable "enable_lambda_edge" {
  description = "Enable Lambda@Edge creation and association in CloudFront distributions"
  type        = bool
  default     = false
}


# Marker-based replacement variables
variable "cors_origins" {
  description = "List of allowed CORS origins"
  type        = list(string)
  default     = []
}

variable "csp_config" {
  description = "CSP configuration object"
  type = object({
    s3_bucket_name           = string
    s3_region               = string
    api_cloudfront_domain   = string
    cognito_region          = string
    cognito_user_pool_id    = string
    s3_assets_bucket        = string
    additional_connect_src  = string
    additional_img_src      = string
  })
  default = {
    s3_bucket_name           = ""
    s3_region               = ""
    api_cloudfront_domain   = ""
    cognito_region          = ""
    cognito_user_pool_id    = ""
    s3_assets_bucket        = ""
    additional_connect_src   = ""
    additional_img_src      = ""
  }
}


# variable "placeholderfile" {
#  value = "uat-wdr-maritimeapps-deploy-lambda-initialize-source"
# }


variable "lambda_definitions" {
  description = "Lambda function infra configuration"
  type = map(object({
    function_name    = string
    runtime          = string
    handler          = string
    timeout          = number
    memory_size      = number
    env_vars         = map(string)
    s3_bucket        = optional(string)  # Optional: If not provided, will use dummy_code_bucket
    s3_key           = optional(string)   # Optional: If not provided, will use dummy_code_key (for infra-only creation)
    source_code_hash = optional(string)
    layers           = optional(list(string), [])  # List of layer names (e.g., ["connect_db", "error_codes"])
  }))
}

# Dummy Lambda code configuration (for infra-only Lambda creation)
# CICD will update code later, so we use placeholder code when creating Lambda
variable "dummy_lambda_code_bucket" {
  description = "S3 bucket containing dummy/placeholder Lambda code (used when creating Lambda without real code)"
  type        = string
  default     = null
}

variable "dummy_lambda_code_key" {
  description = "S3 key for placeholder Lambda code (e.g., 'placeholder-files/lambda-placeholder.zip')"
  type        = string
  default     = null
}


variable "lambda_code_updates" {
  type = map(object({
    function_name = string
    s3_bucket     = string
    s3_key        = string
    # source_code_hash  = string
    # zip_path = string

  }))
  default = {}
}

#variable "lambda_code_update" {
#  description = "Whether to update the lambda code"
#  type        = bool
#  default     = false
#}

# variable "lambda_functions" {
#   description = "Map of Lambda function configurations"
#   type = map(object({
#     function_name = string
#     runtime       = string
#     handler       = string
#     timeout       = number
#     memory_size   = number
#     env_vars      = map(string)
#   }))
# }

variable "lambda_code" {
  description = "Map of Lambda function code configurations"
  type = map(object({
    function_name = string
    s3_key        = string
  }))
  default = {}
}

variable "s3_bucket" {
  description = "S3 bucket containing Lambda code"
  type        = string
  default     = null
}

variable "lambda_bucket_name" {
  description = "S3 bucket name for Lambda code"
  type        = string
  default     = null
}

#REST API GATEWAY
variable "apis" {
  description = "Map of API Gateways with their names and paths"
  type = map(object({
    api_name = string
    api_paths = map(object({
      parent_path           = string
      child_path            = string
      grandchild_path       = string
      great_grandchild_path = optional(string, "")
      http_methods = list(object({
        method           = string
        lambda_key       = string
        template_file    = optional(string)
        request_template = optional(string)
        enable_auth      = optional(bool, true)  # Bật/tắt authorization cho method này. Default: true (bật)
      }))
    }))
  }))
}

variable "api_paths" {
  type = map(object({
    parent_path           = string
    child_path            = string
    grandchild_path       = string
    great_grandchild_path = optional(string, "")
    http_methods = list(object({
      method           = string
      lambda_key       = string
      template_file    = optional(string)
      request_template = optional(string)
      enable_auth      = optional(bool, true)  # Bật/tắt authorization cho method này. Default: true (bật)
    }))
  }))
  default = {}
}

#WEBSOCKET API GATEWAY
variable "websocket_apis" {
  description = "Map of WebSocket API Gateways with their configurations"
  type = map(object({
    api_name              = string
    connect_lambda_key    = string
    disconnect_lambda_key = string
    route_selection_expression = optional(string, "$request.body.action")
    stage_name            = optional(string, "prod")
    enable_access_logs     = optional(bool, false)  # Enable CloudWatch access logs (default: true - recommended cho production)
    # ========================================
    # CUSTOM ROUTES - UNCOMMENT KHI CẦN XỬ LÝ MESSAGE TỪ CLIENT
    # ========================================
    # custom_routes = optional(map(object({
    #   route_key  = string  # Route key (e.g., "sendMessage", "subscribe")
    #   lambda_key  = string  # Key in lambda_functions map
    # })), {})
  }))
  default = {}
}

variable "lambda_release_version" {
  description = "Release version for Lambda code"
  type        = string
  default     = "release1.0"
}

variable "lambda_release_date" {
  description = "Release date for Lambda code"
  type        = string
  default     = "06212025"
}

# variable "user_pools" {
#   type = map(object({
#     name                                 = string
#     client_name                          = string
#     allowed_oauth_flows_user_pool_client = bool
#     allowed_oauth_flows                  = list(string)
#     allowed_oauth_scopes                 = list(string)
#     supported_identity_providers         = list(string)
#     callback_urls                        = list(string)
#     logout_urls                          = list(string)
#     explicit_auth_flows                  = list(string)
#     refresh_token_validity               = number
#     access_token_validity                = number
#     id_token_validity                    = number
#     token_validity_units = object({
#       access_token  = string
#       id_token      = string
#       refresh_token = string
#     })
#   }))
# }

# --- Block này bị sai, không cần khai báo ở root module vì chỉ dùng ở module con ---
# variable "cloudfront_distributions" {
#   description = "Map of CloudFront distributions"
#   type = map(object({
#     origin_domain_name = string
#   }))
# }

variable "s3_buckets" {
  type = map(object({
    name = string
  }))
}

# SQS Queues
variable "sqs_queues" {
  type = map(object({
    name                      = string
    delay_seconds             = optional(number, 0)
    retention_seconds         = optional(number, 345600)  # Default: 4 days
    visibility_timeout        = optional(number, 60)
    receive_wait_time         = optional(number, 0)  # Receive message wait time: 0 = short polling, >0 = long polling (max 20s)
    lambda_keys               = optional(list(string), [])  # List of lambda keys to integrate
    batch_size                = optional(number, 10)
    batching_window           = optional(number, 0)
    max_retry_attempts        = optional(number, -1)  # -1 = unlimited
    enabled                   = optional(bool, true)
  }))
  default = {}
  description = "SQS queues với Lambda integrations"
}

# #cap nhat bien lambda_functions, chuyen qua dung S3 voi s3_bucket va s3_key
# # variable "lambda_functions" {
# #   description = "Map of Lambda function definitions"
# #   type = map(object({
# #     function_name = string
# #     runtime       = string
# #     handler       = string
# #     timeout       = optional(number, 10)
# #     memory_size   = optional(number, 128)
# #     env_vars      = optional(map(string), {})
# #     s3_bucket     = string
# #     s3_key        = string
# #   }))
# #   default = {}
# # }

variable "lambda_zips" {
  type = map(object({
    bucket_key  = string
    source_path = string
  }))
  default = {}
}



variable "rds_clusters" {
  type = map(object({
    cluster_identifier     = string
    engine                 = string
    engine_version         = string
    master_username        = string
    master_password        = string
    database_name          = string
    vpc_security_group_ids = list(string)
  }))
}

variable "rds_instances" {
  type = map(object({
    cluster_identifier = string
    instance_class     = string
    identifier         = string
    # publicly_accessible = bool
  }))
}

variable "db_subnet_group_name" {
  description = "Tên nhóm subnet cơ sở dữ liệu cho cụm RDS"
  type        = string
  default     = "prod-wdr-subnetgroup"  # ← DB SUBNET GROUP MỚI
}

variable "fe_bucket_domain_name" {
  description = "S3 bucket domain name for FE CloudFront distribution"
  type        = string
}



variable "db_cluster_parameter_group_name" {
  description = "Tên DB cluster parameter group cho Aurora PostgreSQL"
  type        = string
  default     = null
}

# variable "db_name" {
#   description = "Database name for RDS"
#   type        = string
# }

# variable "db_password" {
#   description = "Database password for RDS"
#   type        = string
#   sensitive   = true
# }

variable "cognito_user_pool_arn" {
  description = "ARN of the Cognito User Pool for API Gateway authentication. Thay đổi giá trị này nếu đổi Cognito."
  type        = string
}

variable "enable_cognito_auth" {
  description = "Bật/tắt Cognito authorizer cho API Gateway. Để false nếu Cognito chưa sẵn sàng, true để bật xác thực."
  type        = bool
  default     = false
}

variable "cognito_proxy_distribution" {
  description = "Cognito Proxy CloudFront Distribution configuration"
  type = object({
    enabled = bool
    certificate_arn = string
  })
  default = {
    enabled = false
    certificate_arn = ""
  }
}

variable "create_schedule_group" {
  description = "Whether to create a new schedule group. If false, will use existing group with scheduler_group_name"
  type        = bool
  default     = true
}

variable "enable_oac_for_fe" {
  description = "Enable Origin Access Control for FE S3 buckets"
  type        = bool
  default     = false
}

# VPC Configuration
# variable "vpc_config" {
#   description = "VPC configuration for Lambda functions"
#   type = object({
#     subnet_ids         = list(string)
#     security_group_ids = list(string)
#   })
#   default = {
#     # ========================================
#     # VPC MỚI - TMA PROD VPC NEW
#     # ========================================
#     subnet_ids = [
#       "subnet-0fa6b4178d3fd1701",  # tma-prod-subnet1-new-vpc (thay bằng SubnetId thực tế)
#       "subnet-0c32beb0f7cf18609",  # tma-prod-subnet2-new-vpc (thay bằng SubnetId thực tế)
#     ]
#     security_group_ids = [
#       "sg-0e9fbf8110087bdbe"  # TMA-Prod-securitygroup-new-vpc (thay bằng SecurityGroupId thực tế)
#     ]
    
    
#   }
# }

variable "vpc_config" {
  description = "VPC configuration for Lambda functions"
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  default = {
    # ========================================
    # VPC CŨ - TMA PROD VPC OLD (COMMENTED)
    # ========================================
    subnet_ids = [
      "subnet-04209231a3d7228f3",  # Private subnet 1 (từ prod-subnet) - OLD VPC
      "subnet-04ab3f9c0a097c75f",  # Private subnet 2 (từ prod-subnet) - OLD VPC
      # "subnet-02b54f220fe9050fc"   # Private subnet 3 (từ prod-subnet) - OLD VPC
    ]
    security_group_ids = [
      "sg-02075d1c9a946c549"  # Security group cho phép Lambda kết nối RDS - OLD VPC
    ]
    
    
  }
}

# Step Functions State Machine Configuration
variable "state_machines" {
  description = "Map of Step Functions state machine configurations"
  type = map(object({
    state_machine_name = string
    definition_file    = optional(string)  # Path to ASL JSON file
    definition_json    = optional(string)  # Inline ASL JSON definition
    template_file      = optional(string)   # Path to template file (.tpl.json) - ARN sẽ được tự động inject từ lambda functions
    lambda_arn_mapping = optional(map(string), {})  # Map function names to ARNs for replacement
    existing_role_arn   = optional(string)  # ARN of existing IAM role to use. If provided, a new role will not be created
    iam_policy_statements = optional(list(object({
      Effect   = string
      Action   = list(string)
      Resource = list(string)
    })), [])  # IAM policy statements for new role. Ignored if existing_role_arn is provided
    enable_logging         = optional(bool, false)
    log_group_arn         = optional(string)
    include_execution_data = optional(bool, true)
    log_level             = optional(string, "ALL")
    enable_tracing        = optional(bool, false)
    additional_tags       = optional(map(string), {})
  }))
  default = {}
}







