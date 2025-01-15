# Log Group 
resource "aws_cloudwatch_log_group" "lambda_post_log_group" {
  name              = "lambda_post_log_group"
  retention_in_days = 30
}

# Roles para a lambda
resource "aws_iam_role" "lambda_post_role" {
  name = "lambda_post_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_post_cloudwatch_policy" {
  role       = aws_iam_role.lambda_post_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_post_dynamodb_policy" {
  role       = aws_iam_role.lambda_post_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_lambda_function" "lambda_post" {
  function_name = "lambda_post"
  filename      = "person_post.zip"
  handler       = "person_post.lambda_handler"
  runtime       = "python3.13"
  role          = aws_iam_role.lambda_post_role.arn
  memory_size   = 128
  timeout       = 30

  logging_config {
    log_format = "Text"
    log_group  = aws_cloudwatch_log_group.lambda_post_log_group.name
  }

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamo_table_name
    }
  }
}