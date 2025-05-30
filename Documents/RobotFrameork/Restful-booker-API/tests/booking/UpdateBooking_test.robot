*** Settings ***
Documentation     Test suite for updating bookings
Resource          ../../resources/base.robot

*** Test Cases ***
Update Existing Booking
    [Documentation]    Test updating an existing booking
    ${token}=    Get Auth Token
    ${booking_id}=    Create Test Booking
    
    ${updated_data}=    Create Dictionary
    ...    firstname=UpdatedJohn
    ...    lastname=UpdatedDoe
    ...    totalprice=200
    ...    depositpaid=${FALSE}
    ...    bookingdates=${{"checkin": "2024-02-01", "checkout": "2024-02-05"}}
    ...    additionalneeds=Dinner
    
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    PUT    url=${BASE_URL}/booking/${booking_id}    
    ...    json=${updated_data}    
    ...    headers=${headers}    
    ...    expected_status=200
    
    Validate Booking Response    ${response.json()}    ${updated_data}

Update Booking Without Authentication
    [Documentation]    Test updating a booking without authentication
    ${booking_id}=    Create Test Booking
    
    ${updated_data}=    Create Dictionary
    ...    firstname=UpdatedJohn
    ...    lastname=UpdatedDoe
    ...    totalprice=200
    ...    depositpaid=${FALSE}
    ...    bookingdates=${{"checkin": "2024-02-01", "checkout": "2024-02-05"}}
    ...    additionalneeds=Dinner
    
    ${response}=    PUT    url=${BASE_URL}/booking/${booking_id}    
    ...    json=${updated_data}    
    ...    expected_status=403

*** Keywords ***
Get Auth Token
    ${credentials}=    Create Dictionary    username=admin    password=password123
    ${response}=    POST    url=${BASE_URL}/auth    json=${credentials}    expected_status=200
    RETURN    ${response.json()}[token]

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

Validate Booking Response
    [Arguments]    ${response}    ${expected}
    Should Be Equal    ${response}[firstname]    ${expected}[firstname]
    Should Be Equal    ${response}[lastname]    ${expected}[lastname]
    Should Be Equal    ${response}[totalprice]    ${expected}[totalprice]
    Should Be Equal    ${response}[depositpaid]    ${expected}[depositpaid]
    Dictionary Should Contain Sub Dictionary    ${response}[bookingdates]    ${expected}[bookingdates]
    Should Be Equal    ${response}[additionalneeds]    ${expected}[additionalneeds]