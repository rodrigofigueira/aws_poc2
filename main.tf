terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.83.1"
    }
  }

  required_version = ">= 1.10.4"
}

resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = var.default_description
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}