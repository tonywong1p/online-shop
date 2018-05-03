<%
    'Connect DB
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.recordset")
    cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
    conn.open(cs)

    'Update Password
    password = Request.Form("password")
    sql="UPDATE USERACCOUNT SET PASSWORD='"&password&"' "&_
    "WHERE CUSTOMER_ID='"&Application("customer_id")&"'"
    conn.Execute sql,recaffected
    
    'Update personal information
    first_name = Request.Form("first_name")
    last_name = Request.Form("last_name")
    email = Request.Form("email")
    gender = Request.Form("gender")
    phone_no = Request.Form("phone_no")
    birthday = Request.Form("birthday")
    address = Request.Form("address")
    country = Request.Form("country")

    sql="UPDATE CUSTOMER SET "&_
    "FIRST_NAME='"&first_name&"',"&_
    "LAST_NAME='"&last_name&"',"&_
    "EMAIL='"&email&"',"&_
    "GENDER='"&gender&"',"&_
    "PHONE_NO='"&phone_no&"',"&_
    "BIRTHDAY='"&birthday&"',"&_
    "CUSTOMER_ADDRESS='"&address&"',"&_
    "CUSTOMER_COUNTRY='"&country&"' "&_
    "WHERE CUSTOMER_ID='"&Application("customer_id")&"'"
    conn.Execute sql,recaffected

    Response.write(sql)

    'Disconnect and Redirect
    conn.close
    Response.Redirect "../default.asp"
%>