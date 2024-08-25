# All locator will be found here
*** Variables ***
${URL}                   http://localhost:8080
${PRODUCT_CARD}          css=.product-page__card
${THUMBNAIL}             css=.lazy-image
${ARTICLE_NAME}          css=.product-page__name
${ARTICLE_PRICE}         css=.product-page__price
${COLOR_BOX}             css=.product-page__color-box
${OVERLAY}               css=.product-view  
${CLOSE_BUTTON}          //*[@id="app"]/div[3]/section/div/div[1]/button  
${SLIDESHOW}             css=.product-gallery__indicators   
${FOOTER}                css=.product-sticky-footer
${MAIN_IMAGE}            css=.lazy-image__img--transition
${COLOR_TEXT}            css=.product-detail__color-value     
${BROWSER}               None
${BROWSERS}              Chrome    Firefox    Edge