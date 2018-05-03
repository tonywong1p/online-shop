<%
    'Connect DB
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.recordset")
    cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
    conn.open(cs)

    submit = Request.Form("submit")
    order_item_id = Request.Form("order_item_id")
    product_id = Request.Form("product_id")
    message = Request.Form("message")

    if submit="update" then
    sql="UPDATE DELIVERY SET DELIVERY_MSG='"&message&"' "&_
    "WHERE ORDERITEM_ID='"&order_item_id&"'"
    conn.Execute sql,recaffected
    end if

    if submit="deliver" then
    sql="UPDATE DELIVERY SET DELIVERY_DATE='"&Date&"',DELIVERY_STATUS='1' "&_
    "WHERE ORDERITEM_ID='"&order_item_id&"'"
    conn.Execute sql,recaffected

    sql="UPDATE PRICEANDSTOCK SET STOCK_QUANTITY=STOCK_QUANTITY-1 "&_
    "WHERE PRODUCT_ID='"&product_id&"' AND VENDOR_ID='"&Application("vendor_id")&"'"
    conn.Execute sql,recaffected
    end if

    'Disconnect and Redirect
    conn.close
    Response.Redirect "../vendor_orders.asp"
%>