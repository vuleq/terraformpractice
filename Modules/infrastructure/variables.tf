variable "subscription_id" {}
variable "tenant_id" {}
variable "prefix" {}
variable "resource_group_name" {}
variable "location" {}
variable "storage_account_name" {}
variable "secondary_storage_account_name" {}

variable "enable_static_web_app" {
  type        = bool
  default     = false
  description = "Enable static web app creation"
}

variable "static_webapp_location" {
  description = "Location for the Static Web App"
  type        = string
  default     = "East Asia"
}


