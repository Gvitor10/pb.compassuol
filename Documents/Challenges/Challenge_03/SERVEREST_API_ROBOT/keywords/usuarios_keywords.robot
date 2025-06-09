*** Settings ***
Documentation       Variables e Keywords do endpoint /usuarios.
Resource            ../support/common/common.robot
Resource            ../support/fixtures/dynamics.robot

*** Keywords ***
GET Endpoint /usuarios
    ${response}         GET On Session      serverest       /usuarios
    Set Global Variable     ${response}

POST Endpoint /usuarios
    ${response}         POST On Session      serverest       /usuarios      json=&{payload}
    Log To Console      ${response.content}
    Set Global Variable     ${response}

PUT Endpoint /usuarios
    &{payload}          Create Dictionary
        ...             nome=admin
        ...             email=admin@gmail.com
        ...             password=123
        ...             administrador=true

    ${response}         PUT On Session      serverest       /usuarios/su0too0iLhzdcU9h      data=&{payload}
    Log To Console      ${response.content}
    Set Global Variable     ${response}

DELETE Endpoint /usuarios
    ${response}         DELETE On Session      serverest       /usuarios/su0too0iLhzdcU9h
    Log To Console      ${response.content}
    Set Global Variable     ${response}

Validar Quantidade "${quantidade}"
    Should Be Equal     ${response.json()["quantidade"]}        ${quantidade}

Validar Quantidade "${quantidade}"
    Should Be Equal     ${response.json()["quantidade"]}        ${quantidade}

Validar Se Mensagem Contem "${palavra}"
    Should Contain      ${response.json()["message"]}       ${palavra}

Printar Conteudo response
    Log To Console      ${response.json()}

Criar Usuario Estatico Valido
    ${json}         Importar Json Estatico  dados_usuario.json
    &{payload}      Set Variable        ${json["usuario_valido"]}
    Set Global Variable     &{payload}
    POST Endpoint /usuarios

Criar Usuario Dinamico Valido
    &{payload}      Criar Dados Usuario Valido
    Set Global Variable     &{payload}
    POST Endpoint /usuarios