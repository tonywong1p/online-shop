<%
    'Connect DB
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.recordset")
    cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
    conn.open(cs)

    order_id=Request.form("order_id")
    payment_type=Request.form("payment_type")

    sql="INSERT INTO PAYMENT (ORDER_ID,PAYMENT_TYPE,PAYMENT_DATE) "&_
    "VALUES ('"&order_id&"','"&payment_type&"','"&Date&"')"
    Response.Write(sql)
    conn.Execute sql,recaffected

    Response.Redirect "../payment_success.html"
%>
