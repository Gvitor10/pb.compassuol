*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     https://restful-booker.herokuapp.com

*** Test Cases ***
Lista com Todas as Reservas Cadastradas
    [Documentation]     Verifica se o endpoint retorna uma array com os Id's das reservas cadastradas.
    Create Session      restful     ${BASE_URL}
    ${response}     GET On Session      restful     /booking

    Log To Console      \nStatus: ${response.status_code}
    Log To Console      \nBody: ${response.text}

    Status Should Be    200     ${response}
    ${bookings}=      Set Variable        ${response.json()}
    Should Be True      ${bookings} != []
    FOR     ${item}     IN      @{bookings}
        Dictionary Should Contain Key   ${item}     bookingid
    ENDw