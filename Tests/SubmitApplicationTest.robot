*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           AutoItLibrary
Suite Setup       Start Browser and Login to Optimy
Suite Teardown    Close Browser

*** Variables ***
${BASE_URL}       http://example.com
${USERNAME}       your_username
${PASSWORD}       your_password
${AUTOIT_SCRIPT}    FileUpload.au3

*** Test Cases ***
SubmitApplicationTest
    [Tags]    smoke    regression
    Given Click Submit New Application Button
    When Fill Out Application Form
    And Click Next Screen Button
    And Verify Inputted Values In Summary
    And Click Validate And Send Button
    Then Verify Redirected To Thank You Page

*** Keywords ***
Start Browser and Login to Optimy
    Given Open Browser    ${BASE_URL}    browser=chrome
    And Maximize Browser Window
    And Login To Application

Login To Application
    Go To    ${BASE_URL}
    Input Text    #login-email.form-control.preventSpace.is-valid    ${USERNAME}
    Input Text    #login-password.form-control.is-valid    ${PASSWORD}
    Click Button    .btn.btn-lg.btn-primary.col-12.mt-1.mt-md-2

Click Submit New Application Button
    Wait Until Keyword Succeeds    3x    10
    ...    Element Should Be Visible    .btn.btn-primary.btn-lg.col-md-auto
    Click Button    .btn.btn-primary.btn-lg.col-md-auto
    Wait Until Keyword Succeeds    3x    10
    ...    Element Should Be Visible    .btn.btn-primary.d-block.d-md-inline-block.mr-md-auto
    ${continue_message}    Get Text    .btn.btn-primary.d-block.d-md-inline-block.mr-md-auto
    Run Keyword If    "'Continue with the submission of the application'" in ${continue_message}"    Scroll Element Into View    a.btn.btn-outline-primary
    Click Button    a.btn.btn-outline-primary

Fill Out Application Form
    Input Text    input[aria-label='First name']    John
    Input Text    input[aria-label='Last name']     Doe
    Input Text    textarea[aria-label='Unit no/House no, Street']       Z house X street Bengaluru, Karnataka
    Input Text    .ui-autocomplete-input[aria-label='Select postal code']       Z house X street Bengaluru, Karnataka
    Select From List by Value    .locationCountry[aria-label='Country']    India
    Run Process    autoit3    ${AUTOIT_SCRIPT}


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
