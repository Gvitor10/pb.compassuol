*** Settings ***
Documentation       Variables e Keywords do endpoint /login.

*** Variables ***
${emailParaLogin}       fulano@qa.com
${passwordParaLogin}    teste

*** Keywords ***
POST Endpoint /login
    &{payload}      Create Dictionary       email=${emailParaLogin}     password=${passwordParaLogin}
    ${response}     POST On Session         serverest       /login      data=&{payload}
    Log To Console      Response: ${response.content}
    Set Global Variable     ${response}

Validar Ter Logado
    Should Be Equal     ${response.json()["message"]}       Login realizado com sucesso
    Should Not Be Empty     ${response.json()["authorization"]}

Fazer Login E Obter Token
    POST Endpoint /login
    Validar Ter Logado
    ${tokenAuth}        Set Variable        ${response.json()["authorization"]}
    Set Global Variable     ${tokenAuth}