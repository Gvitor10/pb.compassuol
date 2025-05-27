*** Settings ***
Documentation     Test suite for creating new bookings
Resource          ../../resources/base.robot

*** Test Cases ***
Create New Booking with Valid Data
    [Documentation]    Test successful booking creation with valid data
    ${booking_data}=    Create Dictionary
    ...    firstname=John
    ...    lastname=Doe
    ...    totalprice=100
    ...    depositpaid=${TRUE}
    ...    bookingdates=${{"checkin": "2024-01-01", "checkout": "2024-01-05"}}
    ...    additionalneeds=Breakfast
    
    ${response}=    POST    url=${BASE_URL}/booking    json=${booking_data}    expected_status=200
    Dictionary Should Contain Key    ${response.json()}    bookingid
    Validate Booking Response    ${response.json()}[booking]    ${booking_data}

Create Booking with Missing Required Fields
    [Documentation]    Test booking creation with missing required fields
    ${booking_data}=    Create Dictionary
    ...    firstname=John
    ...    lastname=Doe
    
    ${response}=    POST    url=${BASE_URL}/booking    json=${booking_data}    expected_status=400

*** Keywords ***
Validate Booking Response
    [Arguments]    ${response}    ${expected}
    Should Be Equal    ${response}[firstname]    ${expected}[firstname]
    Should Be Equal    ${response}[lastname]    ${expected}[lastname]
    Should Be Equal    ${response}[totalprice]    ${expected}[totalprice]
    Should Be Equal    ${response}[depositpaid]    ${expected}[depositpaid]
    Dictionary Should Contain Sub Dictionary    ${response}[bookingdates]    ${expected}[bookingdates]
    Should Be Equal    ${response}[additionalneeds]    ${expected}[additionalneeds]