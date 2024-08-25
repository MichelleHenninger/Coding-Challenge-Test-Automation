*** Settings ***
Library    SeleniumLibrary
Resource    Variabels_locator.resource


*** Keywords ***
Open Overlay For Product
    [Documentation]    Opens Overlay for ${product}
    [Arguments]    ${product}
    Click Element    ${product}${THUMBNAIL}
    Wait Until Element Is Visible    ${OVERLAY}

Close Overlay
    [Documentation]    CLoses the Overlay with the closebutton
    Click Element    ${CLOSE_BUTTON}
    Wait Until Element Is Not Visible    ${OVERLAY}

Get Element Position
    [Documentation]    Searches for the position of a specific element ${locator}
    [Arguments]    ${locator}
    ${position}=    Execute JavaScript    return [arguments[0].getBoundingClientRect().left, arguments[0].getBoundingClientRect().top];    ${locator}
    RETURN    ${position}

Get Image Title
    [Documentation]    get the image title from image name and returns the image title
    [Arguments]    ${locator}
    ${src_attribute}=    Get Element Attribute    ${locator}    src
    ${image_title}=    Get Title From Src    ${src_attribute}
    RETURN   ${image_title}

Get Title From Src
    [Documentation]    Extracts the imagetitle from the src tag
    [Arguments]    ${src}
    # Extract the title between the last '/' and the first '-' in the file name
    ${image_name}=    Evaluate    ${src}.split("/")[-1].split("-")[0].upper()
    RETURN  ${image_name}

Open Product Overlay
    [Documentation]    Opens the overlay for a product on the page.
    Click Element    ${PRODUCT_CARD}${THUMBNAIL}
    Wait Until Element Is Visible    ${OVERLAY}

Verify Overlay Content
    [Documentation]    Verifies that the overlay content is correctly displayed.
    Element Should Be Visible    ${OVERLAY}
    Element Should Be Visible    ${MAIN_IMAGE}
    Element Should Be Visible    ${COLOR_TEXT}


Test Mobile Overlay
    [Arguments]    ${width}    ${height}
    [Documentation]    Opens the overlay and verifies its content on a mobile screen of the given size.
    Set Window Size    ${width}    ${height}
    Open Product Overlay
    Verify Overlay Content
    Close Browser


Run Tests In All Browsers
    [Documentation]    Iterates thgrough all available browsers
    FOR    ${BROWSER}    IN    @{BROWSERS}
        Set Suite Variable    ${BROWSER}
        Run Keyword And Ignore Error    Open Browser For Test
    END

Open Browser For Test
    [Documentation]    Opens the browser with the currently set browser name.
    Open Browser    ${URL}    ${BROWSER}

Close All Browsers
    [Documentation]    Closes all browser instances.
    Close All Browsers

Get Focused Element
    [Documentation]  Returns current focused elements.
    ${element}=    Execute JavaScript    return document.activeElement;
    RETURN    ${element}

Element Should Be Focused
    [Arguments]    ${element}
    [Documentation] 	Checks if ${element} is focused
    Run Keyword If    '${element}' == 'None'    Fail    Kein Element ist fokussiert!
    Log    Aktuelles fokussiertes Element: ${element}


Verify Color Not Selected
    [Documentation]    Verifies that the not choosen colors are not selected
    [Arguments]    ${color}
    ${color_element}=  Get WebElement  xpath=//input[@alt='${color}']
    ${class_attribute}=    Get Element Attribute    ${color_element}    class
    Should Not Contain    ${class_attribute}    cursor-default
    Should Not Contain    ${class_attribute}    border-black