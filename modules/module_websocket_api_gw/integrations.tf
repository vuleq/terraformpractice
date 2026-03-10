# Route $connect - khi client kết nối
resource "aws_apigatewayv2_route" "connect" {
  api_id    = aws_apigatewayv2_api.websocket_api.id
  route_key = "$connect"
  target    = "integrations/${aws_apigatewayv2_integration.connect.id}"
}

# Integration cho $connect route
resource "aws_apigatewayv2_integration" "connect" {
  api_id           = aws_apigatewayv2_api.websocket_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_functions[var.connect_lambda_key].invoke_arn
}

# Route $disconnect - khi client ngắt kết nối
resource "aws_apigatewayv2_route" "disconnect" {
  api_id    = aws_apigatewayv2_api.websocket_api.id
  route_key = "$disconnect"
  target    = "integrations/${aws_apigatewayv2_integration.disconnect.id}"
}

# Integration cho $disconnect route
resource "aws_apigatewayv2_integration" "disconnect" {
  api_id           = aws_apigatewayv2_api.websocket_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_functions[var.disconnect_lambda_key].invoke_arn
}

# Lambda permission cho $connect
resource "aws_lambda_permission" "connect_permission" {
  statement_id  = "AllowExecutionFromAPIGateway-Connect"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_functions[var.connect_lambda_key].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.websocket_api.execution_arn}/*/$connect"
}

# Lambda permission cho $disconnect
resource "aws_lambda_permission" "disconnect_permission" {
  statement_id  = "AllowExecutionFromAPIGateway-Disconnect"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_functions[var.disconnect_lambda_key].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.websocket_api.execution_arn}/*/$disconnect"
}

# ========================================
# CUSTOM ROUTES - UNCOMMENT KHI CẦN XỬ LÝ MESSAGE TỪ CLIENT
# ========================================
# Sử dụng khi:
# - Client gửi message với action cụ thể (ví dụ: {"action": "sendMessage", "data": {...}})
# - Cần routing message đến Lambda khác nhau dựa trên action type
# - Cần xử lý business logic phức tạp từ client message
#
# Ví dụ: 
# - Client gửi: {"action": "sendMessage", "data": {"to": "user123", "message": "Hello"}}
# - API Gateway route đến route key "sendMessage"
# - Lambda "sendMessage" xử lý và có thể gửi response hoặc broadcast
#
# Để sử dụng:
# 1. Uncomment phần code dưới đây
# 2. Thêm custom_routes vào variables.tf (đã có sẵn ở trên, uncomment)
# 3. Thêm custom_routes vào infra.tfvars (xem ví dụ ở cuối file)
# 4. Tạo Lambda functions tương ứng cho mỗi route
# 5. Update main.tf để pass custom_routes vào module

# # Custom routes - xử lý các message từ client
# resource "aws_apigatewayv2_route" "custom" {
#   for_each = var.custom_routes != null ? var.custom_routes : {}
#   
#   api_id    = aws_apigatewayv2_api.websocket_api.id
#   route_key = each.value.route_key  # Ví dụ: "sendMessage", "subscribe", "ping"
#   target    = "integrations/${aws_apigatewayv2_integration.custom[each.key].id}"
# }

# # Integration cho custom routes
# resource "aws_apigatewayv2_integration" "custom" {
#   for_each = var.custom_routes != null ? var.custom_routes : {}
#   
#   api_id           = aws_apigatewayv2_api.websocket_api.id
#   integration_type = "AWS_PROXY"
#   integration_uri  = var.lambda_functions[each.value.lambda_key].invoke_arn
# }

# # Lambda permissions cho custom routes
# resource "aws_lambda_permission" "custom_permission" {
#   for_each = var.custom_routes != null ? var.custom_routes : {}
#   
#   statement_id  = "AllowExecutionFromAPIGateway-${replace(each.value.route_key, "$", "")}"
#   action        = "lambda:InvokeFunction"
#   function_name = var.lambda_functions[each.value.lambda_key].function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_apigatewayv2_api.websocket_api.execution_arn}/*/${each.value.route_key}"
# }

# # Route $default - xử lý các message không match với route nào (optional)
# # Uncomment nếu muốn có fallback handler cho unknown routes
# # resource "aws_apigatewayv2_route" "default" {
# #   api_id    = aws_apigatewayv2_api.websocket_api.id
# #   route_key = "$default"
# #   target    = "integrations/${aws_apigatewayv2_integration.default.id}"
# # }
# 
# # resource "aws_apigatewayv2_integration" "default" {
# #   api_id           = aws_apigatewayv2_api.websocket_api.id
# #   integration_type = "AWS_PROXY"
# #   integration_uri  = var.lambda_functions[var.default_lambda_key].invoke_arn
# # }
# 
# # resource "aws_lambda_permission" "default_permission" {
# #   statement_id  = "AllowExecutionFromAPIGateway-Default"
# #   action        = "lambda:InvokeFunction"
# #   function_name = var.lambda_functions[var.default_lambda_key].function_name
# #   principal     = "apigateway.amazonaws.com"
# #   source_arn    = "${aws_apigatewayv2_api.websocket_api.execution_arn}/*/$default"
# # }

