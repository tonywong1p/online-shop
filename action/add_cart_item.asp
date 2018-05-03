<%
    'Connect DB
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.recordset")
    cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
    conn.open(cs)

    product_id=Request.form("product_id")
    vendor_id=Request.form("vendor_id")
    cart_id=Request.form("cart_id")

    sql="INSERT INTO CART_ITEM (CART_ID,PRODUCT_ID,VENDOR_ID,QUANTITY) "&_
    "VALUES ('"&cart_id&"','"&product_id&"','"&vendor_id&"',1)"
    Response.write(sql)
    conn.Execute sql,recaffected

    'Disconnect and Redirect to Home
    conn.close
    Response.Redirect "../cart.asp"

%>
