variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "storage_account_name" {
  description = "Name for the primary storage account"
  type        = string
}

variable "secondary_storage_account_name" {
  description = "Name for the secondary storage account"
  type        = string
}

variable "enable_static_web_app" {
  type    = bool
  default = true
}

variable "static_webapp_location" {
  description = "Location for Static Web App"
  type        = string
  default     = "East Asia"
}