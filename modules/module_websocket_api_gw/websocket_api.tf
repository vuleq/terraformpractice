resource "aws_apigatewayv2_api" "websocket_api" {
  name                       = var.api_name
  protocol_type              = "WEBSOCKET"
  route_selection_expression = var.route_selection_expression

  # tags = {
  #   Name        = var.api_name
  #   Environment = var.environment
  # }
}

# CloudWatch Log Group - Optional (chỉ tạo khi enable_access_logs = true)
resource "aws_cloudwatch_log_group" "websocket_api_logs" {
  count             = var.enable_access_logs ? 1 : 0
  name              = "/aws/apigateway/${var.api_name}"
  retention_in_days = 7
}

resource "aws_apigatewayv2_stage" "websocket_stage" {
  api_id      = aws_apigatewayv2_api.websocket_api.id
  name        = var.stage_name
  auto_deploy = true

  # Override default_tags với tags rỗng để tránh lỗi permission TagResource
  # tags = {}

  default_route_settings {
    throttling_rate_limit  = 10000
    throttling_burst_limit = 5000
  }

  # Access logs - chỉ enable khi có CloudWatch log group
  dynamic "access_log_settings" {
    for_each = var.enable_access_logs ? [1] : []
    content {
      destination_arn = aws_cloudwatch_log_group.websocket_api_logs[0].arn
      format = jsonencode({
        requestId      = "$context.requestId"
        ip             = "$context.identity.sourceIp"
        requestTime    = "$context.requestTime"
        routeKey       = "$context.routeKey"
        status         = "$context.status"
        connectionId   = "$context.connectionId"
        protocol       = "$context.protocol"
      })
    }
  }

  # Ignore changes cho tags để tránh lỗi permission khi update
  # lifecycle {
  #   ignore_changes = [tags]
  # }

  # depends_on không cần thiết vì Terraform tự động detect dependency qua reference aws_cloudwatch_log_group.websocket_api_logs[0].arn
}

