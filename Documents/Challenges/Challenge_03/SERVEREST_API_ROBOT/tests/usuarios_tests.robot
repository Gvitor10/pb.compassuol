*** Settings ***
Documentation       Arquivo de testes para o endpoint /usuarios.
Resource            ../support/base.robot

Suite Setup         Criar Sessao

*** Test Cases ***
CENARIO: GET Todos os Usuarios 200
    [Tags]      GET
    GET Endpoint /usuarios
    Validar Status Code "200"
    Validar Quantidade "${86}"
    Printar Conteudo response

CENARIO: POST Cadastrar Usuario 201
    [Tags]      POST
    POST Endpoint /usuarios
    Validar Status Code "201"
    Validar Se Mensagem Contem "sucesso"

CENARIO: PUT Editar Usuario 200
    [Tags]      PUT
    PUT Endpoint /usuarios
    Validar Status Code "200"

CENARIO: DELETE Deletar Usuario 200
    [Tags]      DELETE
    DELETE Endpoint /usuarios
    Validar Status Code "200"

CENARIO: POST Criar Usuario De Massa Estatica 201
    [Tags]      POST
    Criar Usuario Estatico Valido
    Validar Status Code "201"

CENARIO: POST Criar Usuario De Massa Dinamica 201
    [Tags]      POST
    Criar Usuario Dinamico Valido
    Validar Status Code "201"