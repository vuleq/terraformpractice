variable "function_name" {}
variable "runtime" {}
variable "handler" {}
variable "timeout" {}
variable "memory_size" {}
variable "role_arn" {}
variable "s3_bucket" {
  description = "S3 bucket containing Lambda code. If null, will use dummy_code_bucket"
  type        = string
  default     = null
}
variable "s3_key" {
  description = "S3 key for Lambda code. If null, will use dummy_code_key (for infra-only creation)"
  type        = string
  default     = null
}
variable "source_code_hash" {
  description = "Source code hash. If null, will be auto-calculated from S3 object"
  type        = string
  default     = null
}
variable "dummy_code_bucket" {
  description = "S3 bucket for dummy/placeholder Lambda code (used when s3_key is not provided)"
  type        = string
  default     = null
}
variable "dummy_code_key" {
  description = "S3 key for dummy/placeholder Lambda code (used when s3_key is not provided)"
  type        = string
  default     = null
}
variable "layers" {
  description = "List of Lambda Layer ARNs to attach to the function"
  type        = list(string)
  default     = []
}
variable "environment" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

# VPC Configuration
variable "vpc_config" {
  description = "VPC configuration for Lambda function"
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  default = null
}