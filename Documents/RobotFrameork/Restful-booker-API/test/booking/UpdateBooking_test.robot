*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     https://restful-booker.herokuapp.com
${BOOKING_ID}   406

*** Test Cases ***
Altear uma Reserva com Sucesso
    [Documentation]     Verifica se é possivél alterar uma reserva já cadastrada.
    Create Session      restful     ${BASE_URL}

    ${token}        Get-Token

    ${payload}          Create Dictionary
        ...             firstname=Gabriel
        ...             lastname=Lobo
        ...             totalprice=150
        ...             depositpaid=False
        ...             bookingdates=${EMPTY}
        ...             additionalneeds=Jantar Completo

    ${bookingdates}=    Create Dictionary    checkin=2025-05-24    checkout=2025-05-25
    Set To Dictionary   ${payload}    bookingdates=${bookingdates}

    ${headers}      Create Dictionary
        ...         Content-Type=application/json       
        ...         Accept=application/json
        ...         Cookie=token=${token}

    ${response}     PUT On Session      restful     booking/${BOOKING_ID}       json=${payload}     headers=${headers}

    Log To Console      \nStatus: ${response.status_code}
    Log To Console      \nBody: ${response.text}

    Status Should Be    200    ${response}

*** Keywords ***
Get-Token
    Create Session      restful     ${BASE_URL}
    ${body}=    Create Dictionary
        ...     username=admin
        ...     password=password123
    ${response}=    POST On Session     restful     /auth       json=${body}
    
    ${token}=    Set Variable    ${response.json()['token']}
    RETURN    ${token}