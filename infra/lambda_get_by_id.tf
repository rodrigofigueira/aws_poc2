# Log Group 
resource "aws_cloudwatch_log_group" "lambda_get_by_id_log_group" {
  name              = "lambda_get_by_id_log_group"
  retention_in_days = 30
}

resource "aws_lambda_function" "lambda_get_by_id" {
  function_name = "lambda_get_by_id"
  filename      = "person_get_by_id.zip"
  handler       = "person_get_by_id.lambda_handler"
  runtime       = "python3.13"
  role          = aws_iam_role.lambda_post_role.arn
  memory_size   = 128
  timeout       = 30

  logging_config {
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.lambda_get_by_id_log_group.name
  }

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamo_table_name
    }
  }
}

# resource "aws_api_gateway_integration" "person_get_by_id_integration" {
#   rest_api_id             = aws_api_gateway_rest_api.api.id
#   resource_id             = aws_api_gateway_resource.person.id
#   http_method             = aws_api_gateway_method.person_get.http_method
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = aws_lambda_function.lambda_get_by_id.invoke_arn

#   depends_on = [
#     aws_api_gateway_method.person_get
#   ]
# }

resource "aws_api_gateway_integration" "person_get_by_id_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.person_id.id
  http_method             = aws_api_gateway_method.person_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_get_by_id.invoke_arn

  depends_on = [
    aws_api_gateway_method.person_get
  ]
}



resource "aws_lambda_permission" "allow_apigateway_invoke_get_by_id" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_get_by_id.function_name
  principal     = "apigateway.amazonaws.com"

  # A fonte do evento vem da API Gateway REST API específica
  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
