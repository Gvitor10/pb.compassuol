*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variables ***
${BASE_URL}     https://restful-booker.herokuapp.com
${BOOKING_ID}   408

*** Test Cases ***
Encontrar uma Reserva com Base no Id Fornecido
    [Documentation]     Verifica se o endpoint retorna a reserva correspondente ao Id fornecido.
    Create Session      restful     ${BASE_URL}
    ${response}     GET On Session      restful     /booking/${BOOKING_ID}

    Log To Console      \nStatus: ${response.status_code}
    Log To Console      \nBody: ${response.text}

    Run Keyword If      ${response.status_code} == 404      Log To Console      Nehuma reserva com o ID ${BOOKING_ID} foi encontrado.
    Status Should Be        200     ${response}
    Should Not Be Empty     ${response.json()}