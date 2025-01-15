resource "aws_dynamodb_table" "dynamo_table" {
  name         = var.dynamo_table_name
  hash_key     = "id"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }

}