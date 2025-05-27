*** Settings ***
Documentation    Test suite for booking creation operations
Resource         ../resources/base.robot

Test Setup        Setup Test
Test Teardown     Teardown Test

*** Test Cases ***
Create Booking Successfully
    [Documentation]    Verifies if it's possible to create a booking successfully
    ${response}=    Create Booking    
    ...    firstname=${DEFAULT_BOOKING.firstname}
    ...    lastname=${DEFAULT_BOOKING.lastname}
    ...    totalprice=${DEFAULT_BOOKING.totalprice}
    ...    depositpaid=${DEFAULT_BOOKING.depositpaid}
    ...    checkin=${DEFAULT_BOOKING.checkin}
    ...    checkout=${DEFAULT_BOOKING.checkout}
    ...    additionalneeds=${DEFAULT_BOOKING.additionalneeds}
    
    Dictionary Should Contain Key    ${response.json()}    bookingid
    Dictionary Should Contain Key    ${response.json()}    booking
    
    ${booking}=    Set Variable    ${response.json()}[booking]
    Verify Booking Details    ${booking}    ${DEFAULT_BOOKING.firstname}    ${DEFAULT_BOOKING.lastname}    ${DEFAULT_BOOKING.totalprice}

Create Booking With Custom Data
    [Documentation]    Verifies if it's possible to create a booking with custom data
    ${response}=    Create Booking    
    ...    firstname=Maria    
    ...    lastname=Santos    
    ...    totalprice=200    
    ...    depositpaid=${TRUE}    
    ...    checkin=2024-11-01    
    ...    checkout=2024-11-10    
    ...    additionalneeds=Dinner included
    
    Dictionary Should Contain Key    ${response.json()}    bookingid
    Dictionary Should Contain Key    ${response.json()}    booking
    
    ${booking}=    Set Variable    ${response.json()}[booking]
    Verify Booking Details    ${booking}    Maria    Santos    200