# Variables for EventBridge Scheduler Module

variable "scheduler_name" {
  description = "Name of the EventBridge scheduler"
  type        = string
}

variable "scheduler_group_name" {
  description = "Name of the EventBridge scheduler group"
  type        = string
  default     = "prod-wdr-maritimeapps-schedulers"
}

variable "create_schedule_group" {
  description = "Whether to create a new schedule group. If false, will use existing group with scheduler_group_name"
  type        = bool
  default     = true
}

variable "target_lambda_arn" {
  description = "ARN of the target Lambda function to invoke"
  type        = string
}

variable "target_lambda_function_name" {
  description = "Name of the target Lambda function (for permission)"
  type        = string
}

variable "environment" {
  description = "Environment name (prod, uat, dev)"
  type        = string
  default     = "prod"
}

variable "enabled" {
  description = "Whether the scheduler is enabled"
  type        = bool
  default     = true
}

variable "lambda_input" {
  description = "Input payload to send to Lambda function"
  type        = map(string)
  default     = null
}

variable "max_retry_attempts" {
  description = "Maximum number of retry attempts"
  type        = number
  default     = 3
}

variable "max_event_age" {
  description = "Maximum event age in seconds before giving up"
  type        = number
  default     = 3600
}

variable "dead_letter_queue_arn" {
  description = "ARN of the dead letter queue (optional)"
  type        = string
  default     = null
}

variable "schedule_expression" {
  description = "Schedule expression for the scheduler (cron or rate expression)"
  type        = string
  default     = "cron(0 22 * * ? *)"  # Default: 6:00 AM UTC+8 (Singapore time)
}

variable "existing_role_arn" {
  description = "ARN of the existing IAM role to use for EventBridge scheduler"
  type        = string
}

variable "additional_tags" {
  description = "Additional tags for the scheduler group"
  type        = map(string)
  default     = {}
}
