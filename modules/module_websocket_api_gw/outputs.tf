output "websocket_api_name" {
  description = "The name of the WebSocket API Gateway"
  value       = aws_apigatewayv2_api.websocket_api.name
}

output "websocket_api_id" {
  description = "The ID of the WebSocket API Gateway"
  value       = aws_apigatewayv2_api.websocket_api.id
}

output "websocket_api_endpoint" {
  description = "The WebSocket API endpoint URL"
  value       = aws_apigatewayv2_api.websocket_api.api_endpoint
}

output "websocket_api_arn" {
  description = "The ARN of the WebSocket API Gateway"
  value       = aws_apigatewayv2_api.websocket_api.arn
}

output "websocket_api_execution_arn" {
  description = "The execution ARN of the WebSocket API Gateway"
  value       = aws_apigatewayv2_api.websocket_api.execution_arn
}

output "websocket_stage_name" {
  description = "The stage name of the WebSocket API"
  value       = aws_apigatewayv2_stage.websocket_stage.name
}

output "websocket_connect_url" {
  description = "The full WebSocket connection URL"
  value       = "wss://${aws_apigatewayv2_api.websocket_api.api_endpoint}/${var.stage_name}"
}

output "websocket_connections_base_url" {
  description = "The base URL for @connections API (Management API) - format: https://{api_endpoint}/{stage_name}/"
  # Strip any existing protocol (wss://, ws://, https://, http://) từ api_endpoint để đảm bảo chỉ dùng domain name
  # Sau đó thêm https:// protocol (dùng https:// chứ không phải wss:// vì đây là để gọi Management API)
  # Sử dụng replace nhiều lần để strip các protocol (compatible với mọi Terraform version)
  value       = "https://${replace(replace(replace(replace(aws_apigatewayv2_api.websocket_api.api_endpoint, "wss://", ""), "ws://", ""), "https://", ""), "http://", "")}/${var.stage_name}/"
}

