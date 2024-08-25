*** Settings ***
Library    SeleniumLibrary
Resource    Variabels_locator.resource


*** Keywords ***
Open Overlay For Product
    [Arguments]    ${product}
    Click Element    ${product}${THUMBNAIL}
    Wait Until Element Is Visible    ${OVERLAY}

Close Overlay
    Click Element    ${CLOSE_BUTTON}
    Wait Until Element Is Not Visible    ${OVERLAY}

Get Element Position
    [Arguments]    ${locator}
    ${position}=    Execute JavaScript    return [arguments[0].getBoundingClientRect().left, arguments[0].getBoundingClientRect().top];    ${locator}
    RETURN    ${position}

Get Image Title
    [Arguments]    ${locator}
    ${src_attribute}=    Get Element Attribute    ${locator}    src
    ${image_title}=    Get Title From Src    ${src_attribute}
    RETURN   ${image_title}

Get Title From Src
    [Arguments]    ${src}
    # Extract the title between the last '/' and the first '-' in the file name
    ${image_name}=    Evaluate    ${src}.split("/")[-1].split("-")[0].upper()
    RETURN  ${image_name}