# outputs.tf - only active outputs that don't reference commented-out modules

# output "api_gateway_urls" {
#   description = "Map of API Gateway URLs for each API"
#   value = {
#     for key, api in module.rest_api_gw : key => api.api_gateway_url
#   }
# }

# output "stage_names" {
#   description = "Map of stage names for each API"
#   value = {
#     for key, api in module.rest_api_gw : key => api.stage_name
#   }
# }

# output "websocket_api_names" {
#   description = "Map of WebSocket API names for each WebSocket API"
#   value = {
#     for key, api in module.websocket_api_gw : key => api.websocket_api_name
#   }
# }

# output "websocket_stage_names" {
#   description = "Map of WebSocket stage names for each WebSocket API"
#   value = {
#     for key, api in module.websocket_api_gw : key => api.websocket_stage_name
#   }
# }

# Commented out - module.core_resources is disabled for 2-lambda test
# output "rds_cluster_endpoint" { ... }
# output "rds_endpoints" { ... }
# output "rds_reader_endpoint" { ... }
