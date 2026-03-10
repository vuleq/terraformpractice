# Variables for Step Functions State Machine Module

variable "state_machine_name" {
  description = "Name of the Step Functions state machine"
  type        = string
}

variable "definition_file" {
  description = "Path to the state machine definition file (ASL JSON). If provided, definition_json will be ignored"
  type        = string
  default     = null
}

variable "definition_json" {
  description = "State machine definition as JSON string (ASL format). Used if definition_file is not provided"
  type        = string
  default     = null
}

variable "lambda_arn_mapping" {
  description = "Map of Lambda function names to their ARNs. Used to replace placeholders in definition (e.g., {\"my-lambda\" = \"arn:aws:lambda:...\"})"
  type        = map(string)
  default     = {}
}

variable "account_id" {
  description = "AWS Account ID. Used for ARN replacement if lambda_arn_mapping is not provided"
  type        = string
  default     = null
}

variable "region" {
  description = "AWS Region. Used for ARN replacement if lambda_arn_mapping is not provided"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment name (prod, uat, dev)"
  type        = string
  default     = "prod"
}

variable "existing_role_arn" {
  description = "ARN of existing IAM role to use for state machine. If provided, a new role will not be created"
  type        = string
  default     = null
}

variable "iam_policy_statements" {
  description = "List of IAM policy statements for the state machine role. Only used if existing_role_arn is not provided"
  type = list(object({
    Effect   = string
    Action   = list(string)
    Resource = list(string)
  }))
  default = []
}

variable "enable_logging" {
  description = "Enable CloudWatch Logs for state machine executions"
  type        = bool
  default     = false
}

variable "log_group_arn" {
  description = "ARN of the CloudWatch Log Group for state machine logs"
  type        = string
  default     = null
}

variable "include_execution_data" {
  description = "Include execution data in CloudWatch Logs"
  type        = bool
  default     = true
}

variable "log_level" {
  description = "Log level for state machine (ALL, ERROR, FATAL, OFF)"
  type        = string
  default     = "ALL"
}

variable "enable_tracing" {
  description = "Enable X-Ray tracing for state machine"
  type        = bool
  default     = false
}

variable "additional_tags" {
  description = "Additional tags for the state machine"
  type        = map(string)
  default     = {}
}

