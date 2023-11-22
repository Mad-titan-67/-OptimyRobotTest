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
${AUTOIT_SCRIPT}    ../Resource/FileUpload.au3

*** Test Cases ***
SubmitApplicationTest
    [Tags]    smoke    regression
    Given Click Submit New Application Button
    And Fill Out Application Form
    And Click Next Screen Button
    And Verify Inputted Values In Summary
    When Click Validate And Send Button
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
    Wait Until Keyword Succeeds    3x    10
    ...    Element Should Be Visible    input[aria-label='First name']
    #first name
    Input Text    input[aria-label='First name']    John
    #Last Name
    Input Text    input[aria-label='Last name']     Doe
    #address
    Input Text    textarea[aria-label='Unit no/House no, Street']       Z house X street Bengaluru, Karnataka
    #pincode
    Input Text    .ui-autocomplete-input[aria-label='Select postal code']    2560
    Wait Until Element Is Visible    .ui-autocomplete [role='presentation']
    Click Element    .ui-autocomplete [role='presentation']
    #country
    Select From List by Value    .locationCountry[aria-label='Country']    India
    #Photo upload
    Scroll Element Into View    input[name='Filedata']
    Click Element    input[name='Filedata']
    Run Process    autoit3    ${AUTOIT_SCRIPT}
    #gender
    Click Radio Button    .custom-radio[aria-label='Male']
    #Role
    Select From List by Value    .custom-select[aria-label="Select a role you're applying for"]    Automation tester
    #skills
    Click Element    .custom-checkbox[aria-label='Robot Framework']
    #objective
    Input Text    .cke_show_borders[aria-label*='Editor']    Something Something Something

Click Next Screen Button
    Click Button    .btn-primary.ml-auto[type='submit']

Verify Inputted Values In Summary
    ${first_name}    Get Text    .answer.view div.field
    
Click Validate And Send Button
    Click Button    .btn-primary.ml-md-auto[type='submit']

Verify Redirected To Thank You Page
    Wait Until Page Contains    Thank you for submitting your project
