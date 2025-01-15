# Crud Serverless

Este projeto é uma prova de conceito (PoC) que demonstra como criar um Crud Serverless, utilizando Lambda, Api Gateway, S3, Cognito e DynamoDB. Toda a infraestrutura necessária é provisionada utilizando o Terraform.

# Todo list
- [x] Deixar o nome da tabela no dynamo dinâmica nas lambdas ( env )
- [ ] Verificar uma forma de zipar as lambdas automaticamente
- [ ] Criar integração da api com lambda
- [x] Verificar como deletar Log Groups ao destruir infra

## Payload de teste da lambda na AWS

```bash
"body": {
    "id": "123",
    "nome": "Nome Teste",
    "dtNascimento": "2021-10-19 10:11:00",
    "ativo": true
}
```
