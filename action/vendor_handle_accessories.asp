<%
    'Connect DB
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.recordset")
    cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
    conn.open(cs)


    submit=Request.form("submit")
    product_id=Request.form("product_id")
    vendor_id=Application("vendor_id")
    price=Request.form("price")
    stock=Request.form("stock")
    discount=Request.form("discount")

    if submit="update" then
    sql="UPDATE PRICEANDSTOCK SET "&_
    "PRICE='"&price&"',"&_
    "STOCK_QUANTITY='"&stock&"',"&_
    "DISCOUNT='"&discount&"' "&_
    "WHERE VENDOR_ID='"&vendor_id&"' AND PRODUCT_ID='"&product_id&"'"
    Response.write(sql)
    conn.Execute sql,recaffected
    end if

    if submit="delete" then
    sql="DELETE FROM PRICEANDSTOCK "&_
    "WHERE VENDOR_ID='"&vendor_id&"' AND PRODUCT_ID='"&product_id&"'"
    conn.Execute sql,recaffected
    end if

    Response.redirect "../vendor_accessories.asp"
%>