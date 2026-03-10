variable "api_name" {
  description = "Name of the WebSocket API Gateway"
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

variable "environment" {
  description = "Environment"
  type        = string
}

variable "connect_lambda_key" {
  description = "Key in lambda_functions map for the $connect route Lambda"
  type        = string
}

variable "disconnect_lambda_key" {
  description = "Key in lambda_functions map for the $disconnect route Lambda"
  type        = string
}

variable "route_selection_expression" {
  description = "Route selection expression for WebSocket API"
  type        = string
  default     = "$request.body.action"
}

variable "stage_name" {
  description = "Stage name for WebSocket API deployment"
  type        = string
  default     = "PROD"
}

variable "enable_access_logs" {
  description = "Enable CloudWatch access logs for WebSocket API. Recommended: true cho production để dễ debug và monitor. Set false để tiết kiệm chi phí nếu không cần logs."
  type        = bool
  default     = false  # Default true cho production - dễ debug và monitor
}

# ========================================
# CUSTOM ROUTES - UNCOMMENT KHI CẦN XỬ LÝ MESSAGE TỪ CLIENT
# ========================================
# Ví dụ use cases: Chat, Notification, Real-time commands, etc.
# variable "custom_routes" {
#   description = "Map of custom routes with their Lambda function keys"
#   type = map(object({
#     route_key      = string  # Route key (e.g., "sendMessage", "subscribe", "ping")
#     lambda_key     = string  # Key in lambda_functions map
#   }))
#   default = {}
# }

