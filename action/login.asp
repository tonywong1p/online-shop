<%
    'Connect DB
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.recordset")
    cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
    conn.open(cs)
 
    'SQL Query
    sql = "select USER_NAME,USERACCOUNT.CUSTOMER_ID,FIRST_NAME,LAST_NAME from USERACCOUNT INNER JOIN CUSTOMER ON USERACCOUNT.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID"
    sql = sql & " where USER_NAME = " & "'" & Request.Form("username") & "'"
    sql = sql & " and PASSWORD = " &  "'" & Request.Form("password") & "'"
    Response.Write(sql)

    'Run SQL
    rs.open sql,cs,3

    'Logic Check if Login Success
    if rs.RecordCount > 0 then
        Application.Lock
        Application("username") = rs.Fields(0)
        Application("customer_id") = rs.Fields(1)
        Application("fullname") = UCase(rs.Fields(2) & " " & rs.Fields(3))
        Application("loggedIn") = 1
        Application.UnLock
    else
        Application("loggedInFail") = 1
        Response.Redirect "../login_fail.html"
    end if

    'Disconnect and Redirect to Home
    rs.close
    conn.close
    Response.Redirect "../default.asp"

%>
