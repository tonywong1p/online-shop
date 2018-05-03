<%
    'Connect DB
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.recordset")
    cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
    conn.open(cs)

    deleted_item=Request.form("delete")
    sql="DELETE FROM CART_ITEM WHERE CART_ITEMCODE='"&deleted_item&"'"
    conn.Execute sql,recaffected

    'Disconnect and Redirect to Home
    conn.close
    Response.Redirect "../cart.asp"

%>
