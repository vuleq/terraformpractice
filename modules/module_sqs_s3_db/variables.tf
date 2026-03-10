#phan update moi cho DB:
# root/modules/module_sqs_s3_db/variables.tf
variable "environment" {
  type = string
  description = "Môi trường triển khai (ví dụ: staging, prod)"
}

variable "s3_buckets" {
  type = map(object({
    name = string
  }))
  default = {}
  description = "Danh sách các bucket S3"
}

variable "lambda_zips" {
  type = map(object({
    bucket_key  = string
    source_path = string
  }))
  default = {}
  description = "Danh sách các file ZIP Lambda"
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
    batch_size                = optional(number, 10)  # Number of messages to process per batch
    batching_window           = optional(number, 0)  # Maximum batching window in seconds
    max_retry_attempts        = optional(number, -1)  # -1 = unlimited retries
    enabled                   = optional(bool, true)  # Enable/disable event source mapping
    dlq_key                   = optional(string, null)  # Key of DLQ queue (must exist in same sqs_queues map)
    max_receive_count         = optional(number, 3)  # Max receive count before sending to DLQ
  }))
  default = {}
  description = "List of SQS queues with Lambda integrations"
}

variable "rds_clusters" {
  type = map(object({
    cluster_identifier      = string
    engine                  = string
    engine_version          = string
    master_username         = string
    master_password         = string
    database_name           = string
    vpc_security_group_ids  = list(string)
  }))
  description = "Cấu hình các cụm RDS"
}

variable "rds_instances" {
  type = map(object({
    cluster_identifier = string
    instance_class     = string
    identifier         = string
  }))
  description = "Cấu hình các phiên bản RDS"
}

variable "db_subnet_group_name" {
  description = "Tên nhóm subnet cơ sở dữ liệu cho cụm RDS"
  type        = string
  default     = null
}

variable "cluster_identifier" {
  description = "Định danh cụm mặc định"
  type        = string
  default     = "wdr-prod"
}
#tma thoi khoa lai de update rds_cluster va instance moi
# variable "rds_clusters" {
#   type = map(object({
#     cluster_identifier      = string
#     engine                  = string
#     engine_version          = string
#     master_username         = string
#     master_password         = string
#     database_name           = string
#     vpc_security_group_ids  = list(string)
#   }))
#   description = "Cấu hình các cụm RDS"
# }

# variable "rds_instances" {
#   type = map(object({
#     cluster_identifier = string
#     instance_class     = string
#     identifier         = string
#   }))
#   description = "Cấu hình các phiên bản RDS"
# }

variable "region" {
  description = "Vùng AWS để triển khai tài nguyên"
  type        = string
}

variable "lambda_functions" {
  type = map(object({
    arn           = string
    function_name = string
    invoke_arn    = string
  }))
  default = {}
  description = "Map of Lambda functions with ARN, function_name, and invoke_arn"
}

# variable "db_subnet_group_name" {
#   description = "Tên nhóm subnet cơ sở dữ liệu cho cụm RDS"
#   type        = string
#   default     = null
# }

# variable "subnet_ids" {
#   description = "Danh sách ID subnet cho nhóm subnet cơ sở dữ liệu"
#   type        = list(string)
#   default     = []
# }

# variable "cluster_identifier" {
#   description = "Định danh cụm mặc định"
#   type        = string
#   default     = "wdr-staging"
# }

variable "db_cluster_parameter_group_name" {
  description = "Tên DB cluster parameter group cho Aurora PostgreSQL"
  type        = string
  default     = null
}








#phan cu cua variables
# variable "environment" {
#   type = string
# }

# variable "s3_buckets" {
#   type = map(object({
#     name = string
#   }))
#   default = {}
# }

# #cap nhat them cho bien lambda_zips
# variable "lambda_zips" {
#   type = map(object({
#     bucket_key  = string
#     source_path = string
#   }))
#   default = {}
# }



# variable "rds_clusters" {
#   type = map(object({
#     cluster_identifier = string
#     engine             = string
#     engine_version     = string
#     master_username           = string
#     master_password           = string
#     database_name            = string
#     # vpc_security_group_ids = list(string)
#   }))
# }

# variable "rds_instances" {
#   type = map(object({
#     cluster_identifier = string
#     instance_class     = string
#     identifier         = string
#     # publicly_accessible = bool
#   }))
# }

# variable "region" {
#   description = "AWS region to deploy resources"
#   type        = string
# }

# variable "lambda_functions" {
#   type = map(object({
#     function_name = string
#     handler       = string
#     runtime       = string
#     timeout       = number
#     memory_size   = number
#     s3_bucket     = string
#     s3_key        = string
#     env_vars      = map(string)
#   }))
#   default = {}
# }