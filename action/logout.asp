<%  
    'Logout
    Application.Lock
    Application("username") = ""
    Application("customer_id") = ""
    Application("fullname") = ""
    Application("admin_id") = ""
    Application("vendor_id") = ""
    Application("vendor_name") = ""
    Application("vendor_address") = ""
    Application("vendor_tele") = ""
    Application("loggedIn") = 0
    Application.UnLock
    Response.Write("Success to logout")
    Response.Redirect "../default.asp"
%>
