# Crud Serverless

Este projeto é uma prova de conceito (PoC) que demonstra como criar um Crud Serverless, utilizando Lambda, Api Gateway, S3, Cognito e DynamoDB. Toda a infraestrutura necessária é provisionada utilizando o Terraform.

# Todo list
- [x] Deixar o nome da tabela no dynamo dinâmica nas lambdas ( env )
- [ ] Verificar uma forma de zipar as lambdas automaticamente
- [x] Criar integração da api com lambda
- [x] Verificar como deletar Log Groups ao destruir infra
- [x] Criar Método GetPorId
- [x] Criar Lambda para pesquisar GetPorId
- [x] Provisionar lambda get por Terraform
- [ ] Incluir cognito
- [ ] Organizar arquivos em /infra por tipos (ex.: lambdas, api_gateway, etc...)

## Payload de teste da lambda na AWS

```bash
{
    "id": "3456",
    "nome": "Nome Teste 555",
    "dtNascimento": "1990-12-31 10:11:00",
    "ativo": false
}
```
