<%
    'Connect DB
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.recordset")
    cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
    conn.open(cs)

    'Update Password
    password = Request.Form("password")
    sql="UPDATE ADMIN SET PASSWORD='"&password&"' "&_
    "WHERE ADMIN_ID='"&Application("admin_id")&"'"
    conn.Execute sql,recaffected
    
    'Update personal information
    vendor_address = Request.Form("vendor_address")
    vendor_tele = Request.Form("vendor_tele")


    sql="UPDATE VENDOR SET "&_
    "VENDOR_ADDRESS='"&vendor_address&"',"&_
    "VENDOR_TELE='"&vendor_tele&"' "&_
    "WHERE VENDOR_ID='"&Application("vendor_id")&"'"
    conn.Execute sql,recaffected

    Response.write(sql)

    'Disconnect and Redirect
    conn.close
    Response.Redirect "../vendor_default.asp"
%>