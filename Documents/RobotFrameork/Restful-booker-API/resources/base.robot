*** Settings ***
Documentation     Base resource file with common variables and keywords
Library           RequestsLibrary
Library           Collections
Resource          ../keywords/auth_keywords.robot
Resource          ../keywords/booking_keywords.robot

*** Variables ***
${BASE_URL}         https://restful-booker.herokuapp.com
${ADMIN_USER}       admin
${ADMIN_PASSWORD}   password123

&{DEFAULT_BOOKING}    
...    firstname=João
...    lastname=Silva
...    totalprice=150
...    depositpaid=${TRUE}
...    checkin=2024-12-01
...    checkout=2024-12-10
...    additionalneeds=Café da manhã

*** Keywords ***
Setup Test
    [Documentation]    Common test setup
    Create Session    restful_booker    ${BASE_URL}    verify=${TRUE}

Setup Test With Auth
    [Documentation]    Test setup with authentication
    Setup Test
    ${token}=    Create Auth Token    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Set Test Variable    ${AUTH_TOKEN}    ${token}

Teardown Test
    [Documentation]    Common test teardown
    Delete All Sessions