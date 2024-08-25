*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Keywords.resource
Suite Setup       Run Tests In All Browsers
Suite Teardown    Close All Browsers
Test Setup        Open Browser For Test
Test Teardown     Close Browser


*** Variables ***
@{PRODUCT_CARDS}     Get WebElements    ${PRODUCT_CARD}

*** Test Cases ***
TC_01 Click on article thumbnail
    [Documentation]    Overlay opens with article details
    FOR    ${product}    IN    @{PRODUCT_CARDS}
        Click Element    ${product}${THUMBNAIL}
        Wait Until Element Is Visible    ${OVERLAY}
        [Teardown]    Close Overlay
    END

TC_02 Check if the overlay can be closed
    [Documentation]    Overlay closes without issues
    FOR    ${product}    IN    @{PRODUCT_CARDS}
        Click Element    ${product}${THUMBNAIL}
        Wait Until Element Is Visible    ${OVERLAY}
        Click Element    ${CLOSE_BUTTON}
        Element Should Not Be Visible    ${OVERLAY}
    END

TC_03 Verify article images in the overlay
    [Documentation]    All images load and are displayed correctly
    FOR    ${product}    IN    @{PRODUCT_CARDS}
        Open Overlay For Product    ${product}
        Wait Until Page Contains Element    ${SLIDESHOW}
        ${image_count}=    Get Element Count    ${SLIDESHOW} img
        Should Be True    ${image_count} > 0
        [Teardown]    Close Overlay
    END

TC_04 Check the display of article name and price
    [Documentation]    Article name and price are displayed correctly
    FOR    ${product}    IN    @{PRODUCT_CARDS}
        Open Overlay For Product    ${product}
        Element Should Be Visible    ${ARTICLE_NAME}
        ${article_name}=    Get Text    ${ARTICLE_NAME}
        Should Not Be Empty    ${article_name}
        Element Should Be Visible    ${ARTICLE_PRICE}
        ${article_price}=    Get Text    ${ARTICLE_PRICE}
        Should Match Regexp    ${article_price}    \d{1,3}(\.\d{3})*(,\d{2})? €  # Check if price matches currency format
        [Teardown]    Close Overlay
    END

TC_05 Verify available colors
    [Documentation]    All available colors are displayed
    FOR    ${product}    IN    @{PRODUCT_CARDS}
        Open Overlay For Product    ${product}
        Element Should Be Visible    ${COLOR_BOX}
        ${color_count}=    Get Element Count    ${COLOR_BOX}
        Should Be True    ${color_count} > 1
        [Teardown]    Close Overlay
    END

TC_06 Verify sticky footer behavior
    [Documentation]    Footer remains sticky at the bottom of the overlay
    FOR    ${product}    IN    @{PRODUCT_CARDS}
        Open Overlay For Product    ${product}
        ${position}=    Get Element Position    ${FOOTER}
        Set Window Size    800    600
        ${new_position}=    Get Element Position    ${FOOTER}
        Should Be Equal    ${position}    ${new_position}
        [Teardown]    Close Overlay
    END

TC_07 Check if overlay content changes when resizing the browser
    [Documentation]    Overlay content adjusts correctly when resizing the browser window
    FOR    ${product}    IN    @{PRODUCT_CARDS}
        Open Overlay For Product    ${product}
        ${initial_content}=    Get Text    ${OVERLAY}
        Set Window Size    1024    768
        ${content_after_resize}=    Get Text    ${OVERLAY}
        Should Not Be Empty    ${content_after_resize}
        Should Not Be Equal    ${initial_content}    ${content_after_resize}
        [Teardown]    Close Overlay
    END

TC_Check_Selected_Color_Matches_Image_Title
    [Documentation]    Verifies that the selected color text matches the image title.
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    FOR    ${product}    IN    @{PRODUCT_CARDS}
        Open Overlay For Product    ${product}
        FOR    ${color_option}    IN    Get WebElements    ${COLOR_BOX}
            Click Element    ${color_option}
            Sleep    2    # Wait for the image to update, adjust as needed
            ${image_title}=    Get Image Title    ${MAIN_IMAGE}
            ${color_text}=    Get Text    ${COLOR_TEXT}
            Should Be Equal    ${image_title}    ${color_text}
        END
        [Teardown]    Close Overlay
    END
    Close Browser

TC_08_Verify_All_Color_Selections
    [Documentation]  Überprüft, ob alle Farboptionen korrekt ausgewählt werden können.

    FOR    ${color}    IN    @{COLORS}
        # Wähle die aktuelle Farbe aus
        ${color_element}=  Get WebElement  xpath=//input[@alt='${color}']
        Click Element    ${color_element}

        # Überprüfe, ob das geklickte Element jetzt die Klasse 'cursor-default' und 'border-black' hat
        ${class_attribute}=    Get Element Attribute    ${color_element}    class
        Should Contain    ${class_attribute}    cursor-default
        Should Contain    ${class_attribute}    border-black

        # Überprüfe, ob alle anderen Farben NICHT ausgewählt sind
        FOR    ${other_color}    IN    @{COLORS}
            Run Keyword Unless    '${other_color}' == '${color}'    
            ...    Verify Color Not Selected    ${other_color}
        END
    END