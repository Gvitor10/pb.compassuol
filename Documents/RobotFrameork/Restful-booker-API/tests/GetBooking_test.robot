*** Settings ***
Documentation    Test suite for retrieving booking operations
Resource         ../resources/base.robot

Test Setup        Setup Test
Test Teardown     Teardown Test

*** Test Cases ***
Get Existing Booking
    [Documentation]    Verifies if the endpoint returns the booking for a given ID
    # First create a booking to ensure we have a valid ID
    ${create_response}=    Create Booking
    ${booking_id}=    Set Variable    ${create_response.json()}[bookingid]
    
    # Now try to retrieve it
    ${response}=    Get Booking    ${booking_id}
    Status Should Be    200    ${response}
    
    ${booking}=    Set Variable    ${response.json()}
    Verify Booking Details    ${booking}    ${DEFAULT_BOOKING.firstname}    ${DEFAULT_BOOKING.lastname}    ${DEFAULT_BOOKING.totalprice}

Get Non-Existent Booking
    [Documentation]    Verifies the behavior when requesting a non-existent booking
    ${invalid_id}=    Set Variable    999999
    Run Keyword And Expect Error    *404*    Get Booking    ${invalid_id}

Get All Booking IDs
    [Documentation]    Verifies if it's possible to retrieve all booking IDs
    ${response}=    Get All Booking IDs
    Status Should Be    200    ${response}
    
    ${bookings}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${bookings}
    Should Be True    len($bookings) > 0