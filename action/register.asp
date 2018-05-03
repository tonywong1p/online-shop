<%
    'Connect DB
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.recordset")
    cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
    conn.open(cs)

    username = Request.Form("username")
    password = Request.Form("password")

    'SQL insert username and passowrd to USERACCOUNT
    sql="INSERT INTO USERACCOUNT (USER_NAME,PASSWORD)"
    sql=sql & " VALUES "
    sql=sql & "('" & username & "',"
    sql=sql & "'" & password & "')"
    Response.Write(sql)

    'Run SQL
    conn.Execute sql,recaffected

    sql="SELECT CUSTOMER_ID FROM USERACCOUNT"
    sql=sql & " WHERE USER_NAME = " & "'" & username & "'"
    Response.Write(sql)
    rs.open sql,cs,3

    Response.Write(rs.Fields(0))

    customer_id = rs.Fields(0)
    first_name = Request.Form("first_name")
    last_name = Request.Form("last_name")
    email = Request.Form("email")
    gender = Request.Form("gender")
    phone_no = Request.Form("phone_no")
    birthday = Request.Form("birthday")
    address = Request.Form("address1")&","& Request.Form("address2")&","& Request.Form("address3")
    country = Request.Form("country")
    
    rs.close

    'SQL insert user info to CUSTOMER
    sql="INSERT INTO CUSTOMER (CUSTOMER_ID,FIRST_NAME,LAST_NAME,EMAIL,GENDER,PHONE_NO,BIRTHDAY,CUSTOMER_ADDRESS,CUSTOMER_COUNTRY)"
    sql=sql & " VALUES "
    sql=sql & "('" & customer_id & "',"
    sql=sql & "'" & first_name & "',"
    sql=sql & "'" & last_name & "',"
    sql=sql & "'" & email & "',"
    sql=sql & "'" & gender & "',"
    sql=sql & "'" & phone_no & "',"
    sql=sql & "'" & birthday & "',"
    sql=sql & "'" & address & "',"
    sql=sql & "'" & country & "')"
    Response.Write(sql)

    'Run SQL
    conn.Execute sql,recaffected

    'SQL insert user id to CART
    sql="INSERT INTO CART (CUSTOMER_ID) VALUES ('"&customer_id&"')"
    conn.Execute sql,recaffected

    'Login
    Application.Lock
    Application.Lock
    Application("username") = username
    Application("customer_id") = customer_id
    Application("fullname") = UCase(first_name & " " & last_name)
    Application("loggedIn") = 1
    Application.UnLock
    Application.UnLock
    Response.Write("Success to login in")

    'Disconnect and Redirect
    conn.close
    Response.Redirect "../default.asp"
%>
