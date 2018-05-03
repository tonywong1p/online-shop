<%
    'Connect DB
    Set conn=Server.CreateObject("ADODB.Connection")
    Set rs=Server.CreateObject("ADODB.recordset")
    cs = "Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
    conn.open(cs)
    
    brand_name=Request.form("brand_name")
    brand_image_url=Request.form("brand_image_url")
    product_name=Request.form("product_name")
    product_image_url=Request.form("product_image_url")
    chipset=Request.form("chipset")
    display=Request.form("display")
    camera=Request.form("camera")
    battery=Request.form("battery")
    os=Request.form("os")
    sim_slot=Request.form("sim_slot")
    thickness=Request.form("thickness")
    width=Request.form("width")
    weight=Request.form("weight")
    height=Request.form("height")
    color=Request.form("color")
    capacity=Request.form("capacity")
    stock=Request.form("stock")
    price=Request.form("price")
    discount=Request.form("discount")
    
    sql="SELECT BRAND_ID FROM BRAND WHERE BRAND_NAME='"&brand_name&"'"
    rs.open sql,cs,3
    
    if rs.RecordCount > 0 then
        brand_id=rs.fields(0)
        rs.close
        Response.write("brand not added:"&brand_id)
    else
        rs.close
        sql="INSERT INTO BRAND (BRAND_NAME,BRAND_IMAGE_URL) "&_
        "VALUES ('"&brand_name&"','"&brand_image_url&"')"
        conn.Execute sql,recaffected
        sql="SELECT BRAND_ID FROM BRAND ORDER BY BRAND_ID DESC"
        rs.open sql,cs,3
        brand_id=rs.fields(0)
        rs.close
        Response.write("brand added:"&brand_id)
    end if

    sql="SELECT * FROM PHONEMODEL"
    rs.open sql,cs,3
    phone_modelcode=rs.RecordCount+1
    rs.close
    
    sql="INSERT INTO PHONEMODEL (PHONE_MODELCODE,CHIPSET,DISPLAY,CAMERA,BATTERY,OPERATING_SYSTEM,SIM_SLOT,THICKNESS,WIDTH,WEIGHT,HEIGHT,PHONEMODEL_IMAGE_URL) "&_
    "VALUES ('"&_
    phone_modelcode&"','"&_
    chipset&"','"&_
    display&" inches','"&_
    camera&"','"&_
    battery&"mAh','"&_
    os&"','"&_
    sim_slot&"','"&_
    thickness&"mm','"&_
    width&"mm','"&_
    weight&"g','"&_
    height&"mm','None')"
    Response.write(sql)
    conn.Execute sql,recaffected

    sql="INSERT INTO PRODUCT (PRODUCT_NAME,CATEGORY_CODE,BRAND_ID,PRODUCT_IMAGE_URL) "&_
    "VALUES ('"&product_name&"','S_P       ','"&brand_id&"','"&product_image_url&"')"
    conn.Execute sql,recaffected
    sql="SELECT PRODUCT_ID FROM PRODUCT ORDER BY PRODUCT_ID DESC"
    rs.open sql,cs,3
    product_id=rs.fields(0)
    rs.close

    sql="INSERT INTO PHONE (PRODUCT_ID,COLOR,CAPACITY,RELEASE_DATE,PHONE_MODELCODE) "&_
    "VALUES ('"&product_id&"','"&color&"','"&capacity&"GB','"&Date&"','"&phone_modelcode&"')"
    conn.Execute sql,recaffected

    sql="INSERT INTO PRICEANDSTOCK (PRODUCT_ID,VENDOR_ID,PRICE,DISCOUNT,STOCK_QUANTITY) "&_
    "VALUES ('"&product_id&"','"&Application("vendor_id")&"','"&price&"','"&discount&"','"&stock&"')"
    conn.Execute sql,recaffected

    Response.redirect "../vendor_default.asp"
%>