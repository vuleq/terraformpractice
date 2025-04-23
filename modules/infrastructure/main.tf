# modules/infrastructure/main.tf

# Create Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Create Application Insights
resource "azurerm_application_insights" "main" {
  name                = "${var.prefix}-appinsights"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.main.id
}

output "instrumentation_key" {
  value     = azurerm_application_insights.main.instrumentation_key
  sensitive = true
}

output "app_id" {
  value = azurerm_application_insights.main.app_id
}

# Create Storage Accounts
resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account" "secondary" {
  name                     = var.secondary_storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create Application Service Plans
resource "azurerm_service_plan" "linux_plan" {
  name                = "${var.prefix}-linux-asp"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_service_plan" "windows_plan" {
  name                = "${var.prefix}-windows-asp"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Windows"
  sku_name            = "Y1"
}

# Create Key Vault

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  name                        = "${var.prefix}-keyvault"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.main.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true
  sku_name                    = "standard"

  access_policy {
    tenant_id = var.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions     = ["Get"]
    secret_permissions  = ["Get"]
    storage_permissions = ["Get"]
  }
}

# Create Function Apps
resource "azurerm_linux_function_app" "main" {
  name                        = "${var.prefix}-linux-funcapp"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.main.name
  service_plan_id             = azurerm_service_plan.linux_plan.id
  storage_account_name        = azurerm_storage_account.main.name
  storage_account_access_key  = azurerm_storage_account.main.primary_access_key
  functions_extension_version = "~4"

  site_config {
    application_stack {
      java_version = "11"
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"       = "java"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.main.instrumentation_key
    "WEBSITE_RUN_FROM_PACKAGE"       = "1"
  }
}

  #Create Function App (Windows)
resource "azurerm_windows_function_app" "main" {
  name                        = "${var.prefix}-windows-funcapp"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.main.name
  service_plan_id             = azurerm_service_plan.windows_plan.id
  storage_account_name        = azurerm_storage_account.secondary.name
  storage_account_access_key  = azurerm_storage_account.secondary.primary_access_key
  functions_extension_version = "~4"

  site_config {
    application_stack {
      java_version = "11"
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"       = "java"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.main.instrumentation_key
    "WEBSITE_RUN_FROM_PACKAGE"       = "1"
  }
}

# Create Static Web App
resource "azurerm_static_web_app" "main" {
  count               = var.enable_static_web_app ? 1 : 0
  name                = "${var.prefix}-webapp"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.static_webapp_location
  sku_tier            = "Free"
  depends_on = [azurerm_resource_group.main]
  # repository_url      = "https://github.com/staticwebapp/sample"
  # branch              = "main"
}

#Create Log Analytic workspace
resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.prefix}-logws"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}



