*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     https://restful-booker.herokuapp.com

*** Test Cases ***
Gerar Token de Autenticação com Sucesso
    [Documentation]     Verifica se o endpoint retorna um token válido.
    Create Session      restful     ${BASE_URL}
    ${body}=    Create Dictionary
        ...     username=admin
        ...     password=password123
    ${response}=    POST On Session     restful     /auth       json=${body}

    Log To Console      \nStatus: ${response.status_code}
    Log To Console      \nBody: ${response.text}

    Status Should Be    200     ${response}
    Dictionary Should Contain Key   ${response.json()}      token
    ${token}    Get From Dictionary     ${response.json()}      token
    Should Not Be Empty     ${token}