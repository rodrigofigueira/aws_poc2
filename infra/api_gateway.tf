resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = var.default_description
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "person" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "person"
}

resource "aws_api_gateway_method" "person_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.person.id
  http_method   = "POST"
  authorization = "NONE"
}