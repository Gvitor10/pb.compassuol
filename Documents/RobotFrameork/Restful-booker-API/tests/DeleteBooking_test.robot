*** Settings ***
Documentation    Test suite for deleting booking operations
Resource         ../resources/base.robot

Test Setup        Setup Test With Auth
Test Teardown     Teardown Test

*** Test Cases ***
Delete Existing Booking
    [Documentation]    Verifies if it's possible to delete an existing booking
    # First create a booking to delete
    ${create_response}=    Create Booking
    ${booking_id}=    Set Variable    ${create_response.json()}[bookingid]
    
    # Delete the booking
    ${response}=    Delete Booking    ${booking_id}    ${AUTH_TOKEN}
    Status Should Be    201    ${response}
    
    # Verify the booking no longer exists
    Run Keyword And Expect Error    *404*    Get Booking    ${booking_id}

Delete Non-Existent Booking
    [Documentation]    Verifies the behavior when deleting a non-existent booking
    ${invalid_id}=    Set Variable    999999
    Run Keyword And Expect Error    *404*    
    ...    Delete Booking    ${invalid_id}    ${AUTH_TOKEN}

Delete Booking Without Authentication
    [Documentation]    Verifies that deleting a booking requires authentication
    ${create_response}=    Create Booking
    ${booking_id}=    Set Variable    ${create_response.json()}[bookingid]
    
    Run Keyword And Expect Error    *403*
    ...    Delete Booking    ${booking_id}    invalid_token