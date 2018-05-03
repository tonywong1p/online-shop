<%
    'Connect DB
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.recordset")
    cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
    conn.open(cs)


    'SQL Query
    sql = "select ADMIN_ID,ADMIN.VENDOR_ID,VENDOR_NAME,VENDOR_ADDRESS,VENDOR_TELE from ADMIN INNER JOIN VENDOR ON ADMIN.VENDOR_ID = VENDOR.VENDOR_ID"
    sql = sql & " where ADMIN_ID = " & "'" & Request.Form("username") & "'"
    sql = sql & " and PASSWORD = " &  "'" & Request.Form("password") & "'"
    Response.Write(sql)

    'Run SQL
    rs.open sql,cs,3

    'Logic Check if Login Success
    if rs.RecordCount > 0 then
        Application.Lock
        Application("admin_id") = rs.Fields(0)
        Application("vendor_id") = rs.Fields(1)
        Application("vendor_name") = rs.Fields(2)
        Application("vendor_address") = rs.Fields(3)
        Application("vendor_tele") = rs.Fields(4)
        Application("loggedIn") = 1
        Application.UnLock
        Response.Write("Admin Success login in")
    else
        Application("loggedInFail") = 1
        Response.Redirect "../login_fail.html"
    end if

    'Disconnect and Redirect to Home
    rs.close
    conn.close
    Response.Redirect "../vendor_default.asp"

%>
