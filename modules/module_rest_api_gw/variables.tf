variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "lambda_functions" {
  description = "Map of Lambda functions with their names and invoke ARNs"
  type = map(object({
    function_name = string
    arn           = string
    invoke_arn    = string
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
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "cognito_user_pool_arn" {
  description = "ARN of the Cognito User Pool for API Gateway authentication. Thay đổi giá trị này nếu đổi Cognito."
  type        = string
}

variable "enable_cognito_auth" {
  description = "Bật/tắt Cognito authorizer cho API Gateway. Để false nếu Cognito chưa sẵn sàng, true để bật xác thực."
  type        = bool
  default     = false
}