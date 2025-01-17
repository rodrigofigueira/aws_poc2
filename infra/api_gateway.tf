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


resource "aws_api_gateway_resource" "person_id" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_resource.person.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "person_get" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.person_id.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  depends_on = [
    aws_api_gateway_method.person_post,
    aws_api_gateway_integration.person_post_integration,
    aws_api_gateway_method.person_get,
    aws_api_gateway_integration.person_get_by_id_integration
  ]
}

resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "dev"
}