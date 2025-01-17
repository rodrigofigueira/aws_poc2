import json
import boto3
import os

DYNAMODB_TABLE = os.environ["DYNAMODB_TABLE"]

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(DYNAMODB_TABLE)

def selecionaIdDoPath(event):
    """
    Extrai o 'id' dos parâmetros de caminho do evento.
    """
    path_parameters = event.get("pathParameters", {})
    return path_parameters.get("id")

def validaId(id):
    """
    Valida se o 'id' está presente e retorna uma resposta de erro se for inválido.
    """
    if not id:
        return {
            "statusCode": 400,
            "body": json.dumps({"message": "Missing 'id' parameter"})
        }
    return None

def buscaItemNoDynamo(id):
    """
    Busca um item no DynamoDB com base no 'id'.
    """
    response = table.get_item(Key={"id": id})
    return response.get("Item")

def lambda_handler(event, context):
    try:
        id = selecionaIdDoPath(event)
        validacao = validaId(id)

        if validacao:
            return validacao

        item = buscaItemNoDynamo(id)

        if not item:
            return {
                "statusCode": 404,
                "body": json.dumps({"message": f"Item with ID {id} not found"})
            }

        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"message": "Item retrieved successfully", "item": item})
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"message": "Error processing event", "error": str(e)}),
        }
