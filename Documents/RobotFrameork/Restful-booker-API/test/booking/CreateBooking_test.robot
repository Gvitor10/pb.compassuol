*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}       https://restful-booker.herokuapp.com

*** Test Cases ***
Criar uma reserva Com Sucesso
    [Documentation]    Verifica se é possível criar uma reserva com sucesso.
    Create Session     restful     ${BASE_URL}

    ${payload}=    Create Dictionary
    ...            firstname=João
    ...            lastname=Silva
    ...            totalprice=150
    ...            depositpaid=True
    ...            bookingdates=${EMPTY}
    ...            additionalneeds=Café da manhã

    ${bookingdates}=    Create Dictionary    checkin=2024-12-01    checkout=2024-12-10
    Set To Dictionary   ${payload}    bookingdates=${bookingdates}

    ${response}=    POST On Session    restful    /booking    json=${payload}
    
    Log To Console     \nStatus: ${response.status_code}
    Log To Console     \nBody: ${response.text}

    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    bookingid
    Dictionary Should Contain Key    ${response.json()}    booking

    ${body}=    Get From Dictionary    ${response.json()}    booking
    Should Be Equal As Strings    ${body["firstname"]}    João
    Should Be Equal As Strings    ${body["lastname"]}     Silva
    Should Be Equal As Numbers    ${body["totalprice"]}   150