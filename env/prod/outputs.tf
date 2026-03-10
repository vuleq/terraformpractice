output "api_gateway_urls" {
  description = "Map of API Gateway URLs for each API"
  value = {
    for key, api in module.rest_api_gw : key => api.api_gateway_url
  }
}

output "stage_names" {
  description = "Map of stage names for each API"
  value = {
    for key, api in module.rest_api_gw : key => api.stage_name
  }
}

# output "rds_writer_endpoint" {
#   description = "RDS writer endpoint"
#   value       = module.core_resources.rds_writer_endpoint
# }

# output "rds_cluster_endpoint" {
#   description = "RDS cluster endpoint"
#   value       = module.core_resources.rds_cluster_endpoint
# }

# output "cloudfront_distributions" {
#   description = "CloudFront distribution URLs"
#   value = {
#     for key, api in module.rest_api_gw : key => api.stage_name
#   }
# }





# # output "api_gateway_url" {
# #   description = "API Gateway invocation URL"
# #   value       = module.rest_api_gw.api_gateway_url
# # }

# # output "stage_name" {
# #   description = "API Gateway stage name"
# #   value       = module.rest_api_gw.stage_name
# # }

# Expose module outputs for debugging
output "rds_cluster_endpoint" {
  description = "RDS cluster endpoint"
  value       = module.core_resources.rds_cluster_endpoint
}

output "rds_endpoints" {
  description = "All RDS instance endpoints"
  value       = module.core_resources.rds_endpoints
}

output "rds_reader_endpoint" {
  description = "RDS reader endpoint"
  value       = length(module.core_resources.rds_reader_endpoint) > 0 ? module.core_resources.rds_reader_endpoint[0] : null
}
output "websocket_api_names" {
  description = "Map of WebSocket API names for each WebSocket API"
  value = {
    for key, api in module.websocket_api_gw : key => api.websocket_api_name
  }
}

output "websocket_stage_names" {
  description = "Map of WebSocket stage names for each WebSocket API"
  value = {
    for key, api in module.websocket_api_gw : key => api.websocket_stage_name
  }
}

