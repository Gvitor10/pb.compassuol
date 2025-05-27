*** Settings ***
Documentation    Keywords related to authentication operations
Resource         ../resources/base.robot

*** Keywords ***
Create Auth Token
    [Documentation]    Creates an authentication token
    [Arguments]    ${username}=admin    ${password}=password123
    ${credentials}=    Create Dictionary    username=${username}    password=${password}
    ${response}=    POST On Session    restful_booker    /auth    json=${credentials}
    Status Should Be    200    ${response}
    [Return]    ${response.json()}[token]

Get Auth Header
    [Documentation]    Returns the authorization header with token
    [Arguments]    ${token}
    [Return]    &{auth_header}    Cookie=token=${token}