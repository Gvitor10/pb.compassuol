*** Settings ***
Documentation     Test suite for deleting bookings
Resource          ../../resources/base.robot

*** Test Cases ***
Delete Existing Booking
    [Documentation]    Test deleting an existing booking
    ${token}=    Get Auth Token
    ${booking_id}=    Create Test Booking
    
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    DELETE    url=${BASE_URL}/booking/${booking_id}    
    ...    headers=${headers}    
    ...    expected_status=201
    
    # Verify booking no longer exists
    GET    url=${BASE_URL}/booking/${booking_id}    expected_status=404

Delete Booking Without Authentication
    [Documentation]    Test deleting a booking without authentication
    ${booking_id}=    Create Test Booking
    
    ${response}=    DELETE    url=${BASE_URL}/booking/${booking_id}    expected_status=403

Delete Non-Existent Booking
    [Documentation]    Test deleting a booking that doesn't exist
    ${token}=    Get Auth Token
    
    ${headers}=    Create Dictionary    Cookie=token=${token}
    ${response}=    DELETE    url=${BASE_URL}/booking/999999    
    ...    headers=${headers}    
    ...    expected_status=405

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