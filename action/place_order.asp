<%
        'Connect DB
        Set conn=Server.CreateObject("ADODB.Connection")
        Set rs=Server.CreateObject("ADODB.recordset")
        cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
        conn.open(cs)
    
        customer_id=Application("customer_id")
        order_detail=Request.form("order_detail")
        sql="INSERT INTO CUST_ORDER (CUSTOMER_ID,ORDER_DATE,ORDER_DETAIL) VALUES ('"&_
        customer_id&"','"&Date&"','"&order_detail&"')"
        conn.Execute sql,recaffected
    
        sql="SELECT ORDER_ID FROM CUST_ORDER WHERE CUSTOMER_ID='"&customer_id&"' "&_
        "ORDER BY ORDER_ID DESC"
        Response.write(sql)
        rs.open sql,cs,3
        order_id=rs.fields(0)
        rs.close
    
        product_id=Split(Request.form("product_id"),", ")
        vendor_id=Split(Request.form("vendor_id"),", ")
        quantity=Split(Request.form("quantity"),", ")
        order_item_price=Split(Request.form("order_item_price"),", ")
        shipment_method_code=Request.form("shipment_method_code")
    
        for i = 0 to UBound(product_id)
            sql="INSERT INTO ORDER_ITEM (ORDER_ID,PRODUCT_ID,VENDOR_ID,QUANTITY,ORDERITEM_PRICE,ORDERITEM_DISCOUNT) "&_
            "VALUES ('"&order_id&"','"&product_id(i)&"','"&vendor_id(i)&"','"&quantity(i)&"','"&order_item_price(i)&"',1)"
            Response.write(sql)
            conn.Execute sql,recaffected
    
            sql="SELECT ORDERITEM_ID FROM ORDER_ITEM ORDER BY ORDERITEM_ID DESC"
            rs.open sql,cs,3
            order_item_id=rs.fields(0)
            rs.close
    
            sql="INSERT INTO DELIVERY (ORDERITEM_ID,SHIPMENTMETHOD_CODE,DELIVERY_STATUS,DELIVERY_MSG) "&_
            "VALUES ('"&order_item_id&"','"&shipment_method_code&"',0,'None')"
            conn.Execute sql,recaffected
        Next
    
        'Send email to tonywonp1p@msn.com
        Set Mail = CreateObject("CDO.Message")
    
        Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
        Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="smtp.gmail.com"
        Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
    
        Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = 1
    
        Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
    
        Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
        Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") ="tonywong1p89@gmail.com"
        Mail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") ="y26252525"
    
        Mail.Configuration.Fields.Update
    
        Mail.Subject="New Order Placement"
        Mail.From="tonywong1p89@gmail.com"
        Mail.To="tonywong1p@msn.com"
        Mail.HTMLBody="<h4>New order has been placed.</h4>"&_
        "<p>Please login and handle the order ASAP.</p>"
    
        Mail.Send
        Set Mail = Nothing
    
        'Disconnect and Redirect to Home
        conn.close
        Response.Redirect "../orders.asp"
    
%>
