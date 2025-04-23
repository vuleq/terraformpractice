terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
}

module "infrastructure" {
  source                         = "../../modules/infrastructure"
  subscription_id                = var.subscription_id
  tenant_id                      = var.tenant_id
  resource_group_name            = var.resource_group_name
  location                       = var.location
  storage_account_name           = var.storage_account_name
  secondary_storage_account_name = var.secondary_storage_account_name
  prefix                         = var.prefix

  enable_static_web_app = true # 👈 New flag
  static_webapp_location = "East Asia"
}

