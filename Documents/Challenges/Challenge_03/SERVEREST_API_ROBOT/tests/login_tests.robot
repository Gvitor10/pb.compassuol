*** Settings ***
Documentation       Arquivo de testes para o endpoint /login.
Resource            ../support/base.robot
Resource            ../keywords/login_keywords.robot

Suite Setup         Criar Sessao

*** Test Cases ***
CENARIO: POST Realizar Login 200
    [Tags]      POST
    POST Endpoint /login
    Validar Status Code "200"