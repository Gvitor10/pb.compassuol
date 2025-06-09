*** Settings ***
Documentation       Arquivo de testes para o endpoint /produtos.
Resource            ../support/base.robot

Suite Setup         Criar Sessao

*** Test Cases ***
CENARIO: POST Criar Produto 201
    [Tags]      POST
    Fazer Login E Obter Token
    POST Endpoint /produtos
    Validar Status Code "201"

CENARIO: DELETE Excluir Produto 200
    [Tags]      DELETE
    Fazer Login E Obter Token
    Criar Produto E Obter Id
    DELETE Endpoint /produtos
    Validar Status Code "200"