*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Keywords.resource
Suite Setup       Run Tests In All Browsers
Suite Teardown    Close All Browsers
Test Setup        Open Browser For Test
Test Teardown     Close Browser


*** Test Cases ***
TC_12_Verify_Overlay_On_Desktop
    [Documentation]    Verify that the overlay content is correctly displayed on a desktop screen.
    Maximize Browser Window
    Open Product Overlay   
    Verify Overlay Content
    Close Browser

TC_13_Verify_Overlay_On_Tablet
    [Documentation]    Verify that the overlay content is correctly displayed on a tablet screen.
    Set Window Size    768    1024  # Standard tablet resolution
    Open Product Overlay
    Verify Overlay Content
    Close Browser

TC_14_Verify_Overlay_On_Mobile
   [Documentation]    Verify that the overlay content is correctly displayed on different mobile screen sizes.  
    # Test on iPhone 6/7/8
    Test Mobile Overlay    375    667  # iPhone 6/7/8
    # Test on iPhone 6/7/8 Plus
    Test Mobile Overlay    414    736  # iPhone 6/7/8 Plus
    # Test on iPhone X/XS
    Test Mobile Overlay    375    812  # iPhone X/XS
    # Test on Google Pixel 2
    Test Mobile Overlay    411    731  # Pixel 2
    # Test on Samsung Galaxy S5
    Test Mobile Overlay    360    640  # Samsung Galaxy S5
    # Test on iPhone SE
    Test Mobile Overlay    320    568  # iPhone SE


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