*** Settings ***
Documentation     Test suite for authentication token generation
Resource          ../../resources/base.robot

*** Test Cases ***
Generate Token with Valid Credentials
    [Documentation]    Test successful token generation with valid credentials
    ${credentials}=    Create Dictionary    username=admin    password=password123
    ${response}=    POST    url=${BASE_URL}/auth    json=${credentials}    expected_status=200
    Dictionary Should Contain Key    ${response.json()}    token
    Should Not Be Empty    ${response.json()}[token]

Generate Token with Invalid Credentials
    [Documentation]    Test token generation with invalid credentials
    ${credentials}=    Create Dictionary    username=invalid    password=wrong
    ${response}=    POST    url=${BASE_URL}/auth    json=${credentials}    expected_status=200
    Dictionary Should Contain Key    ${response.json()}    reason
    Should Be Equal    ${response.json()}[reason]    Bad credentials