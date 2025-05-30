*** Settings ***
Documentation    Test suite for updating booking operations
Resource         ../resources/base.robot

Test Setup        Setup Test With Auth
Test Teardown     Teardown Test

*** Test Cases ***
Update Existing Booking
    [Documentation]    Verifies if it's possible to update an existing booking
    # First create a booking to update
    ${create_response}=    Create Booking
    ${booking_id}=    Set Variable    ${create_response.json()}[bookingid]
    
    # Prepare update payload
    ${bookingdates}=    Create Dictionary    checkin=2024-10-01    checkout=2024-10-10
    ${update_payload}=    Create Dictionary
    ...    firstname=Pedro
    ...    lastname=Santos
    ...    totalprice=300
    ...    depositpaid=${TRUE}
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=Airport Transfer
    
    # Update the booking
    ${response}=    Update Booking    ${booking_id}    ${AUTH_TOKEN}    ${update_payload}
    Status Should Be    200    ${response}
    
    # Verify the update
    ${booking}=    Set Variable    ${response.json()}
    Verify Booking Details    ${booking}    Pedro    Santos    300

Update Non-Existent Booking
    [Documentation]    Verifies the behavior when updating a non-existent booking
    ${invalid_id}=    Set Variable    999999
    ${update_payload}=    Create Dictionary    firstname=Test    lastname=User
    
    Run Keyword And Expect Error    *404*    
    ...    Update Booking    ${invalid_id}    ${AUTH_TOKEN}    ${update_payload}

Update Booking Without Authentication
    [Documentation]    Verifies that updating a booking requires authentication
    ${create_response}=    Create Booking
    ${booking_id}=    Set Variable    ${create_response.json()}[bookingid]
    
    ${update_payload}=    Create Dictionary    firstname=Test    lastname=User
    Run Keyword And Expect Error    *403*
    ...    Update Booking    ${booking_id}    invalid_token    ${update_payload}