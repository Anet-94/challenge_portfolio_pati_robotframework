*** Settings ***
Library              SeleniumLibrary
Documentation        Suite description #automated tests for scout website


*** Variables ***
${LOGIN URL}         https://scouts.futbolkolektyw.pl/en/
${BROWSER}           Chrome

${TITLE LOGINPAGE}   Scouts panel - sign in
${HEADER FORM}       xpath=//child::div/h5
${INPUT EMAIL}       xpath=//*[@id='login']
${INPUT PASSWORD}    xpath=//*[@id='password']
${ERROR PASS}        xpath=//*[contains(@class, 'MuiTypography-caption')]
${BUTTON SIGNIN}     xpath=//*[contains(@type, 'submit')]

${TITLE DBPAGE}      Scouts panel
${PAGELOGO}          xpath=//*[contains(@title, 'Logo Scouts Panel')]
${BUTTON ADDPLAYER}  xpath=//div[2]/div/div/a/button

${INPUT NAME}        xpath=//*[@name='name']
${INPUT SURNAME}     xpath=//*[@name='surname']
${LEG OPEN LIST}     xpath=//*[@id='mui-component-select-leg']
${LEG RIGHT}         xpath=//*[@id='menu-leg']//li[1]
${LEG LEFT}          xpath=//*[@id='menu-leg']//li[2]
${INPUT AGE}         xpath=//*[@name='age']
${INPUT POSITION}    xpath=//*[@name='mainPosition']
${BUTTON SUBMIT}     xpath=//*[@type='submit']
${TOAST SUCCESS}     xpath=//*[contains(@class, 'toast--success')]


*** Test Cases ***
TC1 log in title of page
    Open login page
    [Teardown]    Close Browser
TC2 log in title in header form
    Open login page
    Compare title login form
    [Teardown]    Close Browser
TC3 log in to the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]    Close Browser
TC4 negative log in to the system
    Open login page
    Type in email
    Type incorrect password
    Click on the Submit button
    Assert visibile error
    [Teardown]    Close Browser
TC5 create player
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Wait Until Element Is Visible    ${BUTTON ADDPLAYER}
    Click on the Add Player
    Type in name
    Type in surname
    Type in left leg
    Type in age
    Type in position
    Press the submit button
    Toast success the form
    [Teardown]    Close Browser

*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be     ${TITLE LOGINPAGE}
Compare title login form
    Element Text Should Be      ${HEADER FORM}      Scouts Panel
Type in email
    Input Text   ${INPUT EMAIL}      user01@getnada.com
Type in password
    Input Text   ${INPUT PASSWORD}   Test-1234
Type incorrect password
    Input Text   ${INPUT PASSWORD}   Test
Assert visibile error
    Wait Until Element Is Visible   ${ERROR PASS}
    Capture Page Screenshot     ErrorPass.png
Click on the Submit button
    Click Element   ${BUTTON SIGNIN}
Assert dashboard
    Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be    ${TITLE DBPAGE}
    Capture Page Screenshot     OpenDashboard.png
Click on the Add Player
    Click Element    ${BUTTON ADDPLAYER}
Type in name
    Input Text      ${INPUT NAME}       Peter
Type in surname
    Input Text      ${INPUT SURNAME}    Pan
Type in left leg
    Click Element   ${LEG OPEN LIST}
    Click Element   ${LEG LEFT}
Type in age
    Input Text      ${INPUT AGE}        29.08.1950
Type in position
    Input Text      ${INPUT POSITION}   captain
Press the submit button
    Click Element    ${BUTTON SUBMIT}
Toast success the form
    Wait Until Element Is Visible   ${TOAST SUCCESS}
    Capture Page Screenshot     AddPlayer.png