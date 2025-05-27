*** Settings ***
Documentation     Test suite for retrieving booking IDs
Resource          ../../resources/base.robot

*** Test Cases ***
Get All Booking IDs
    [Documentation]    Test retrieving all booking IDs
    ${response}=    GET    url=${BASE_URL}/booking    expected_status=200
    Should Be True    ${response.json()}
    @{booking_ids}=    Set Variable    ${response.json()}
    FOR    ${booking_id}    IN    @{booking_ids}
        Dictionary Should Contain Key    ${booking_id}    bookingid
    END

Get Booking IDs with Name Filter
    [Documentation]    Test retrieving booking IDs filtered by name
    # First create a booking with known name
    ${booking_data}=    Create Dictionary
    ...    firstname=FilterTest
    ...    lastname=User
    ...    totalprice=100
    ...    depositpaid=${TRUE}
    ...    bookingdates=${{"checkin": "2024-01-01", "checkout": "2024-01-05"}}
    ...    additionalneeds=Breakfast
    
    POST    url=${BASE_URL}/booking    json=${booking_data}    expected_status=200
    
    ${params}=    Create Dictionary    firstname=FilterTest    lastname=User
    ${response}=    GET    url=${BASE_URL}/booking    params=${params}    expected_status=200
    Should Not Be Empty    ${response.json()}