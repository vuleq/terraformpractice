variable "region" {
  type = string
}

variable "bucket_name" {
  type = string
}

# variable "lock_table_name" {
#   type = string
# }

variable "aws_profile" {
  type = string
}

variable "application" {
  description = "Name for App"
  type        = string
  default     = "Practice"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "VuleTMA"
}

variable "owner" {
  description = "Name of Owners"
  type        = string
  default     = "Vule"
}
