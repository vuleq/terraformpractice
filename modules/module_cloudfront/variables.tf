variable "cloudfront_distributions" {
  description = "Map of CloudFront distributions"
  type = map(object({
    origin_domain_name = string
    origin_path        = optional(string)
    origin_type        = optional(string, "s3") # "s3" hoặc "api_gateway"
    lambda_edge_functions = optional(list(object({
      event_type   = string
      function_arn = string
    })), [])
    s3_assets_bucket_domain = optional(string) # Domain name cho S3 assets bucket (e.g., bucket1.ap-southeast-1.amazonaws.com)
  }))
}

variable "enable_cognito_proxy" {
  description = "Enable Cognito proxy CloudFront distribution"
  type        = bool
  default     = false
}

variable "enable_oac_for_fe" {
  description = "Enable Origin Access Control for FE S3 buckets"
  type        = bool
  default     = false
}

variable "owner" {
  description = "Owner name for tags"
  type        = string
}

variable "application" {
  description = "Application name for tags"
  type        = string
}

variable "environment" {
  description = "Environment name for tags"
  type        = string
}

variable "lambda_edge_role_arn" {
  description = "ARN of the Lambda@Edge IAM role created by customer"
  type        = string
  default     = null
}

variable "enable_lambda_edge" {
  description = "Enable creating Lambda@Edge functions in this module"
  type        = bool
  default     = true
}

variable "lambda_edge_function_names" {
  description = "Map of Lambda@Edge function names to create marker versions for"
  type = map(object({
    runtime     = string
    timeout     = number
    memory_size = number
  }))
  default = {}
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
