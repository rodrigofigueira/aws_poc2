import json
import boto3
import os

dynamodb = boto3.resource('dynamodb')

DYNAMODB_TABLE = os.environ["DYNAMODB_TABLE"]

def gerarObjetoParaEnvio(event):
    body = json.loads(event["body"]) if isinstance(event["body"], str) else event["body"]

    item = {
        "id" : body["id"],
        "nome" : body["nome"],
        "dtNascimento" : body["dtNascimento"],
        "ativo" : body["ativo"]
    }
    return item

def enviarParaDynamo(item):
    table = dynamodb.Table(DYNAMODB_TABLE)
    table.put_item(Item=item)

def lambda_handler(event, context):
    try:
        itemParaDynamo = gerarObjetoParaEnvio(event)
        enviarParaDynamo(itemParaDynamo)

        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Event processed successfully"})
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"message": "Error processing event", "error": str(e)})
        }
