*** Settings ***
Library     SeleniumLibrary
Documentation       Suite description #automated tests for scout website

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}          Chrome
${SIGNINBUTTON}     xpath=//*[contains(@type, 'submit')]
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}    xpath=//*[@id='password']
${PAGELOGO}         xpath=//*[contains(@title, 'Logo Scouts Panel')]
${EXPECTED TITLE}   Scouts panel - sign in
${HEADER OF BOX}    Scouts panel

*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]    Close Browser

*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be     ${EXPECTED TITLE}
Type in email
    Input Text   ${EMAILINPUT}   user01@getnada.com
Type in password
    Input Text   ${PASSWORDINPUT}   Test-1234
Click on the Submit button
    Click Element   ${SIGNINBUTTON}
Assert dashboard
    Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be    ${HEADER OF BOX}
    Capture Page Screenshot     alert.png