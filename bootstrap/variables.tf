variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type    = string
  default = "terraform-state-rg"
}

variable "storage_account_name" {
  type    = string
  default = "tfstate123456"
}

variable "location" {
  type    = string
  default = "Southeast Asia"
}
