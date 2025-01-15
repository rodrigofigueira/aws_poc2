resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = var.default_description
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}