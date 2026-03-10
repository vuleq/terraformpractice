resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = "REST API for ${var.environment} env"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  # tags = {
  #   Name = "${var.owner}_${var.application}_${var.environment}"
  # }
}