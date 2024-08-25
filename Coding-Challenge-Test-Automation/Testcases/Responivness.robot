*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Keywords.resource
Suite Setup       Run Tests In All Browsers
Suite Teardown    Close All Browsers
Test Setup        Open Browser For Test
Test Teardown     Close Browser


*** Test Cases ***
TC_12_Verify_Overlay_On_Desktop
    [Documentation]    Verify that the overlay content is correctly displayed on a desktop screen
    ...    with maximal resolution
    Maximize Browser Window
    Open Product Overlay   
    Verify Overlay Content
    Close Browser

TC_13_Verify_Overlay_On_Tablet
    [Documentation]    Verify that the overlay content is correctly displayed on a tablet screen.
    ...        with a standard tablet resolution
    Set Window Size    768    1024  # Standard tablet resolution
    Open Product Overlay
    Verify Overlay Content
    Close Browser

TC_14_Verify_Overlay_On_Mobile
   [Documentation]    Verify that the overlay content is correctly displayed on different mobile screen sizes.  
    # Test on iPhone 6/7/8
    Test Mobile Overlay    375    667  
    # Test on iPhone 6/7/8 Plus
    Test Mobile Overlay    414    736  
    # Test on iPhone X/XS
    Test Mobile Overlay    375    812  
    # Test on Google Pixel 7
    Test Mobile Overlay    412    915  
    # Test on Samsung Galaxy S5
    Test Mobile Overlay    360    640  
    # Test on iPhone SE
    Test Mobile Overlay    320    568  


TC_15_Test_Responsiveness_On_Screen_Rotation
    [Documentation]    Verify that the content adjusts appropriately on screen rotation for tablets and mobile devices.
    # Portrait mode
    Set Window Size    768    1024 
    Open Product Overlay
    Verify Overlay Content
    # Switch to landscape mode
    Verify Overlay Content
    Set Window Size    1024    768 
    # Testing on a mobile
    # Portrait mode
    Set Window Size    375    667  
    Verify Overlay Content
    # Switch to landscape mode
    Set Window Size    667    375  
    Verify Overlay Content
    Close Browser


TC_19_Verify_Tab_Navigation
    [Documentation]  Check if page can be used with tab by clicking tab and checking if the focused elemt changed
    
    # First element focus
    Press Keys    NONE    TAB
    ${focused}=   Get Focused Element
    Element Should Be Focused    ${focused}

    # Press Tab to switch to next element and check new focused Element
    Press Keys    NONE    TAB
    ${focused}=   Get Focused Element
    Element Should Be Focused    ${focused}

    
    Press Keys    NONE    TAB
    ${focused}=   Get Focused Element
    Element Should Be Focused    ${focused}
    
    # Check if Overlay can be reached
    Press Keys    NONE    TAB
    ${focused}=   Get Focused Element
    ${class_attribute}=    Get Element Attribute    ${focused}    class
    Should Contain    ${class_attribute}    product-gallery__carousel-item--active

    # Chek if  "Add to Cart"-Button can be reached
    Press Keys    NONE    TAB
    ${focused}=   Get Focused Element
    ${class_attribute}=    Get Element Attribute    ${focused}    class
    Should Contain    ${class_attribute}   product-sticky-footer__add-cart-text

    # Check if overlay can be closed with tab and enter 
    Press Keys    NONE    ENTER
    Wait Until Element Is Not Visible    ${OVERLAY}