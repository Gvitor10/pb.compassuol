*** Settings ***
Documentation    Keywords related to booking operations
Resource         ../resources/base.robot

*** Keywords ***
Create Booking
    [Documentation]    Creates a new booking with the given details
    [Arguments]    ${firstname}=João    ${lastname}=Silva    ${totalprice}=150    ${depositpaid}=${TRUE}
    ...    ${checkin}=2024-12-01    ${checkout}=2024-12-10    ${additionalneeds}=Café da manhã
    ${bookingdates}=    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    ${payload}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${totalprice}
    ...    depositpaid=${depositpaid}
    ...    bookingdates=${bookingdates}
    ...    additionalneeds=${additionalneeds}
    
    ${response}=    POST On Session    restful_booker    /booking    json=${payload}
    Status Should Be    200    ${response}
    [Return]    ${response}

Get Booking
    [Documentation]    Retrieves a booking by its ID
    [Arguments]    ${booking_id}
    ${response}=    GET On Session    restful_booker    /booking/${booking_id}
    [Return]    ${response}

Update Booking
    [Documentation]    Updates an existing booking
    [Arguments]    ${booking_id}    ${token}    ${payload}
    ${headers}=    Get Auth Header    ${token}
    ${response}=    PUT On Session    restful_booker    /booking/${booking_id}    
    ...    json=${payload}    headers=${headers}
    [Return]    ${response}

Delete Booking
    [Documentation]    Deletes a booking
    [Arguments]    ${booking_id}    ${token}
    ${headers}=    Get Auth Header    ${token}
    ${response}=    DELETE On Session    restful_booker    /booking/${booking_id}    
    ...    headers=${headers}
    [Return]    ${response}

Get All Booking IDs
    [Documentation]    Retrieves all booking IDs
    ${response}=    GET On Session    restful_booker    /booking
    [Return]    ${response}

Verify Booking Details
    [Documentation]    Verifies the booking details match the expected values
    [Arguments]    ${booking}    ${firstname}    ${lastname}    ${totalprice}
    Should Be Equal As Strings    ${booking["firstname"]}    ${firstname}
    Should Be Equal As Strings    ${booking["lastname"]}     ${lastname}
    Should Be Equal As Numbers    ${booking["totalprice"]}   ${totalprice}