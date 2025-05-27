*** Settings ***
Documentation    Test suite for authentication token operations
Resource         ../resources/base.robot

Test Setup        Setup Test
Test Teardown     Teardown Test

*** Test Cases ***
Create Auth Token Successfully
    [Documentation]    Verifies if it's possible to create an authentication token
    ${token}=    Create Auth Token    ${ADMIN_USER}    ${ADMIN_PASSWORD}
    Should Not Be Empty    ${token}

Create Auth Token With Invalid Credentials
    [Documentation]    Verifies the behavior when using invalid credentials
    Run Keyword And Expect Error    *401*    
    ...    Create Auth Token    invalid_user    invalid_password