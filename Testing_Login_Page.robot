*** Settings ***
Suite Setup
Suite Teardown
Test Setup        Display Login Page    ${loginpage}    ${browser}
Test Teardown     Close Browser
Test Template     Test Login Template    # This template will test all login validation
Library           SeleniumLibrary

*** Variables ***
${loginpage}      file:///D:/Project/Login_Page.html    # This variable keeps login page url
${successpage}    file:///D:/Project/Success.html    # This variable keeps success page url.
${failurepage}    file:///D:/Project/Failed.html    # This variable keeps failure page url.
${username}       admin@muhammetaltunbas.com    # This variable keeps username info
${password}       admin    # This variable keeps password info
${browser}        chrome    # This variable keeps browser info

*** Test Cases ***
Invalid Username
    [Tags]    T1
    invalid    ${password}

Invalid Password
    ${username}    invalid

Empty Username
    ${EMPTY}    ${password}

Empty Password
    ${username}    ${EMPTY}

Empty Username and Password
    ${EMPTY}    ${EMPTY}

Invalid Username And Password
    invalid    invalid

*** Keywords ***
Display Login Page
    [Arguments]    ${loginpage}    ${browser}
    Open Browser    ${loginpage}    ${browser}
    Maximize Browser Window
    Title Should Be    Login Page

Test Login Template
    [Arguments]    ${username}    ${password}
    Input Text    id:email    ${username}
    Input Text    id:password    ${password}
    Capture Page Screenshot    loginpage.png
    Click Button    id:btnsubmit
    Location Should Be    ${failurepage}
    Title Should Be    Login Failed
