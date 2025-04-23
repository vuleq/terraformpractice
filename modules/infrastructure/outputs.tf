output "app_insights_instrumentation_key" {
  value     = azurerm_application_insights.main.instrumentation_key
  sensitive = true
}

output "app_insights_app_id" {
  value = azurerm_application_insights.main.app_id
}

output "static_web_app_name" {
  value       = var.enable_static_web_app ? azurerm_static_web_app.main[0].name : null
  description = "Name of the static web app"
}

