# ─────────────────────────────────────────────
# IAM Role for Lambda execution
# ─────────────────────────────────────────────
resource "aws_iam_role" "lambda_exec" {
  name = "${var.project_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# ─────────────────────────────────────────────
# CloudWatch Log Group
# ─────────────────────────────────────────────
resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.project_name}-function"
  retention_in_days = 14
}

# ─────────────────────────────────────────────
# Lambda Function
# ─────────────────────────────────────────────
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.js"
  output_path = "${path.module}/lambda/function.zip"
}

resource "aws_lambda_function" "main" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "${var.project_name}-function"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  code_sha256   = data.archive_file.lambda_zip.output_base64sha256
  timeout       = 30
  memory_size   = 128

  logging_config {
    log_format            = "JSON"
    application_log_level = "INFO"
    system_log_level      = "WARN"
  }

  environment {
    variables = {
      ENVIRONMENT = "dev"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.lambda,
  ]
}

# ─────────────────────────────────────────────
# API Gateway V2 (HTTP)
# ─────────────────────────────────────────────
resource "aws_apigatewayv2_api" "main" {
  name          = "${var.project_name}-api"
  protocol_type = "HTTP"
  description   = "HTTP API Gateway for ${var.project_name}"
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.main.id
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = aws_lambda_function.main.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "default" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.main.id
  name        = "$default"
  auto_deploy = true
}

# ─────────────────────────────────────────────
# Lambda Permission — allow API Gateway to invoke Lambda
# ─────────────────────────────────────────────
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.main.execution_arn}/*/*"
}
