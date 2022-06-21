*** Settings ***
Library     SeleniumLibrary

*** Test Cases ***
Time Open Website and See Empty Cart
    Open Browser To BNN Page
    Click Cart Icon
    Verify Shopping Cart is Empty
    [Teardown]    Close Browser

Add Item to Cart
    Open Browser To BNN Page
    Add Product To Cart     https://www.bnn.in.th/th/p/apple/apple-iphone/apple-iphone-13-mini-128gb-pink-194252690215_z97qxe    Apple iPhone 13 mini 128GB Pink    1
    Click View Shopping Cart
    Verify Shopping Cart is Contain     Apple iPhone 13 mini 128GB Pink
    Verify Shopping Cart Total Price    ฿25,900
    [Teardown]    Close Browser

Update Quantity on Cart
    Open Browser To BNN Page
    Add Product To Cart     https://www.bnn.in.th/th/p/home-entertainment/jbl-bluetooth-speaker-flip-5-blue-6925281954573_zeqo6z    ลำโพงบลูทูธ JBL Flip 5 Blue    2
    Click View Shopping Cart
    Verify Shopping Cart is Contain     ลำโพงบลูทูธ JBL Flip 5 Blue
    Verify Shopping Cart Total Price    ฿7,980
    Update Item Quantity    4
    Verify Shopping Cart Total Price    ฿15,960
    [Teardown]    Close Browser

Remove Item from Cart
    Open Browser To BNN Page
    Add Product To Cart     https://www.bnn.in.th/th/p/home-entertainment/speaker/portable-speakers/jbl-bluetooth-speaker-20-clip-4-red-6925281979316_zpp2oz    ลำโพงบลูทูธ JBL 2.0 Clip 4 Red    1
    Click View Shopping Cart
    Verify Shopping Cart is Contain     ลำโพงบลูทูธ JBL 2.0 Clip 4 Red
    Verify Shopping Cart Total Price    ฿2,510
    Click Delete Button
    Verify Shopping Cart Page is Empty
    [Teardown]    Close Browser

*** Keywords ***
Open Browser To BNN Page
    Open Browser        https://www.bnn.in.th/th/pages/contact-us   chrome
    Title Should Be     BaNANA สินค้าอุปกรณ์ IT ราคาถูก มีครบ ช้อปไอที ต้องที่ BNN.in.th

Click Cart Icon
    Click Element   class:cart

Verify Shopping Cart is Empty
    Wait Until Element Contains  //*[@class='cart']/div/div/div/div[2]/h3    ไม่มีสินค้าในตะกร้า\    timeout=5

Add Product To Cart
    [Arguments]     ${product_url}      ${product_name}     ${quantity}
    Go To   ${product_url}
    Element Text Should Be  //*[@class='page-title product-name']   ${product_name}
    Input Text  //*[@class='input-product-quantity']    ${quantity}
    Click Element   //*[@class='btn btn-add-to-cart -tertiary']

Click View Shopping Cart
    Wait Until Page Contains Element    //*[@class='btn -secondary btn-view-shopping-cart']     timeout=5
    Click Element   //*[@class='btn -secondary btn-view-shopping-cart']
    Wait Until Page Contains Element    //*[@class='cart-product-detail']   timeout=5
    Location Should Contain     /cart

Verify Shopping Cart is Contain
    [Arguments]     ${product}
    Wait Until Page Contains Element    //*[@class='product-description']/a     timeout=5
    Element Text Should Be  //*[@class='product-description']/a     ${product}

Verify Shopping Cart Total Price
    [Arguments]     ${total_price}
    Wait Until Element Contains    //*[@class='price-estimated -space-between']/b[2]    ${total_price}
    Element Text Should Be  //*[@class='price-estimated -space-between']/b[2]    ${total_price}

Update Item Quantity
    [Arguments]     ${quantity}
    Input Text  //*[@class='input-product-quantity']    ${quantity}
    Press Keys    None    RETURN

Click Delete Button
    Click Element   //*[@class='btn btn-delete']

Verify Shopping Cart Page is Empty
    Wait Until Page Contains Element     //*[@class='cart-product-empty']/div/h3    timeout=5
    Element Text Should Be  //*[@class='cart-product-empty']/div/h3    ไม่มีสินค้าในตะกร้า