*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     https://restful-booker.herokuapp.com
${BOOKING_ID}   408

*** Test Cases ***
Deletar uma Reserva Com Sucesso
    [Documentation]     Testa a exclusão de uma reserva existente
    Create Session      restful     ${BASE_URL}

    ${token}        Get-Token

    ${headers}      Create Dictionary
        ...         Content-Type=application/json       
        ...         Accept=application/json
        ...         Cookie=token=${token}

    ${response}     DELETE On Session      restful     /booking/${BOOKING_ID}      headers=${headers}

    Log To Console      \nStatus: ${response.status_code}
    Log To Console      \nBody: ${response.text}

    Status Should Be        201     ${response}

*** Keywords ***
Get-Token
    Create Session      restful     ${BASE_URL}
    ${body}=    Create Dictionary
        ...     username=admin
        ...     password=password123
    ${response}=    POST On Session     restful     /auth       json=${body}
    
    ${token}=    Set Variable    ${response.json()['token']}
    RETURN    ${token}