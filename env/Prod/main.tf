module "infrastructure" {
  source = "../../modules/infrastructure"

  subscription_id               = var.subscription_id
  tenant_id                     = var.tenant_id
  prefix                        = var.prefix
  resource_group_name           = var.resource_group_name
  location                      = var.location
  storage_account_name          = var.storage_account_name
  secondary_storage_account_name = var.secondary_storage_account_name

  enable_static_web_app = true 
  static_webapp_location = "East Asia"
}
