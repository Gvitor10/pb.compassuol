*** Settings ***
Documentation     Test suite for retrieving booking details
Resource          ../../resources/base.robot

*** Test Cases ***
Get Existing Booking Details
    [Documentation]    Test retrieving details of an existing booking
    # First create a booking to ensure we have valid ID
    ${booking_id}=    Create Test Booking
    
    ${response}=    GET    url=${BASE_URL}/booking/${booking_id}    expected_status=200
    Validate Booking Structure    ${response.json()}

Get Non-Existent Booking
    [Documentation]    Test retrieving a booking that doesn't exist
    ${response}=    GET    url=${BASE_URL}/booking/999999    expected_status=404

*** Keywords ***
Create Test Booking
    ${booking_data}=    Create Dictionary
    ...    firstname=Test
    ...    lastname=User
    ...    totalprice=100
    ...    depositpaid=${TRUE}
    ...    bookingdates=${{"checkin": "2024-01-01", "checkout": "2024-01-05"}}
    ...    additionalneeds=Breakfast
    
    ${response}=    POST    url=${BASE_URL}/booking    json=${booking_data}    expected_status=200
    RETURN    ${response.json()}[bookingid]

Validate Booking Structure
    [Arguments]    ${booking}
    Dictionary Should Contain Key    ${booking}    firstname
    Dictionary Should Contain Key    ${booking}    lastname
    Dictionary Should Contain Key    ${booking}    totalprice
    Dictionary Should Contain Key    ${booking}    depositpaid
    Dictionary Should Contain Key    ${booking}    bookingdates
    Dictionary Should Contain Key    ${booking}[bookingdates]    checkin
    Dictionary Should Contain Key    ${booking}[bookingdates]    checkout