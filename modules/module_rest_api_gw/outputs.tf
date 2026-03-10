output "template_debug" {
  description = "Debug template assignments"
  value = {
    for item in flatten([
      for path_key, path in var.api_paths : [
        for method in path.http_methods : {
          key = "${path_key}_${method.method}"
          path_key = path_key
          method = method.method
          lambda_key = method.lambda_key
        }
      ]
    ]) : item.key => item
  }
}

output "api_gateway_url" {
  description = "The URL of the API Gateway"
  value       = "https://${aws_api_gateway_rest_api.api.id}.execute-api.${var.aws_region}.amazonaws.com/${var.environment}"
}

output "stage_name" {
  description = "The stage name of the API Gateway deployment"
  value       = var.environment
}

output "api_domain_name" {
  description = "The domain name of the API Gateway"
  value       = "${aws_api_gateway_rest_api.api.id}.execute-api.${var.aws_region}.amazonaws.com"
}

output "api_origin_path" {
  description = "The origin path for the API Gateway"
  value       = "/${var.environment}"
}

