*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem

*** Variables ***
${BASE_URL}       http://example.com
${USERNAME}       your_username
${PASSWORD}       your_password

*** Test Cases ***
SubmitApplicationTest
    [Tags]    smoke    regression
    Open Browser    ${BASE_URL}    browser=chrome
    Maximize Browser Window
    Login To Application
    Click Submit New Application Button
    Fill Out Application Form
    Click Next Screen Button
    Verify Inputted Values In Summary
    Click Validate And Send Button
    Verify Redirected To Thank You Page
    Close Browser

*** Keywords ***
Login To Application
    Go To    ${BASE_URL}
    Input Text    id=username    ${USERNAME}
    Input Text    id=password    ${PASSWORD}
    Click Button    css:.login-button

Click Submit New Application Button
    ${continue_message}    Get Text    css:.continue-message
    Run Keyword If    "'Continue with the submission of the application'" in ${continue_message}"    Click Button    css:.submit-new-application-button

Fill Out Application Form
    Input Text    id=firstname    John
    Input Text    id=lastname     Doe
    Input Text    id=email        john.doe@example.com
    Select From List by Value    id=country    US
    Click Button    css:.submit-button

Click Next Screen Button
    Click Button    css:.next-screen-button

Verify Inputted Values In Summary
    ${first_name}    Get Text    css:.summary-firstname
    ${last_name}     Get Text    css:.summary-lastname
    ${email}         Get Text    css:.summary-email
    ${country}       Get Text    css:.summary-country

    Should Be Equal As Strings    ${first_name}    John
    Should Be Equal As Strings    ${last_name}     Doe
    Should Be Equal As Strings    ${email}         john.doe@example.com
    Should Be Equal As Strings    ${country}       US

Click Validate And Send Button
    Click Button    css:.validate-send-button

Verify Redirected To Thank You Page
    Wait Until Page Contains    Thank you for submitting your project
