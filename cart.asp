<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Carter+One|Expletus+Sans:600|Marmelad" rel="stylesheet">
        <link rel="stylesheet" href="./main.css">
        <title>Mobile World</title>
    </head>


    <%
        Set conn=Server.CreateObject("ADODB.Connection")
        Set rs=Server.CreateObject("ADODB.recordset")
        cs="Driver={SQL Server};Server=137.189.76.26;Database=Team31;Uid=team31;Pwd=qveggpkl"
        conn.open(cs)
    %>

    <body>
        <nav class="navbar navbar-expand-sm navbar-light bg-primary navbar-dark">
            <a class="navbar-brand font-expletus" href="./default.asp">Mobile World</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarProduct" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Product
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarProduct">
                            <a class="dropdown-item" href="./phones.asp">Mobile Phone</a>
                            <a class="dropdown-item" href="./accessories.asp">Accessory</a>
                        </div>
                    </li>
                    <%
                        if Application("loggedIn")=1 then
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="./orders.asp">Order Record</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./profile.asp">Profile</a>
                    </li>
                    <%end if%>
                </ul>
                <%
                    if Application("loggedIn")=0 then
                %>
                <a href="signup.asp" class="btn btn-info mr-2">Sign up</a>
                <a href="login.html" class="btn btn-info">Login</a>
                <%end if%>
                <%
                    if Application("loggedIn")=1 then
                %>
                <a href="./profile.asp" class="btn btn-link text-light mr-2">Welcome! <%=Application("fullname")%></a>
                <a href="./action/logout.asp" class="btn btn-info">Logout</a>
                <%end if%>
            </div>
        </nav>

        <%
            sql="SELECT PNS_SP.PRODUCT_IMAGE_URL,PNS_SP.VENDOR_NAME Vendor,PRODUCT_NAME Name,BRAND_NAME Brand,CATEGORY_NAME Category,PRICE,DISCOUNT,QUANTITY,PNS_SP.PRODUCT_ID,CART_ITEM.CART_ITEMCODE,PNS_SP.VENDOR_ID FROM CART_ITEM "&_
            "INNER JOIN CART ON CART.CART_ID=CART_ITEM.CART_ID "&_
            "INNER JOIN (SELECT V.*,P_C_B.*,PNS.PRICE,PNS.DISCOUNT,PNS.STOCK_QUANTITY FROM PRICEANDSTOCK PNS "&_
            "INNER JOIN VENDOR V ON PNS.VENDOR_ID=V.VENDOR_ID "&_
            "INNER JOIN ("&_
            "SELECT P.*,C.CATEGORY_NAME,B.BRAND_NAME,B.BRAND_IMAGE_URL FROM PRODUCT P "&_
            "INNER JOIN CATEGORY C ON P.CATEGORY_CODE=C.CATEGORY_CODE "&_
            "INNER JOIN BRAND B ON P.BRAND_ID=B.BRAND_ID"&_
            ") P_C_B ON PNS.PRODUCT_ID=P_C_B.PRODUCT_ID"&_
            ") PNS_SP ON CART_ITEM.PRODUCT_ID=PNS_SP.PRODUCT_ID AND CART_ITEM.VENDOR_ID=PNS_SP.VENDOR_ID "&_
            "WHERE CUSTOMER_ID='"&Application("customer_id")&"'"
            rs.open sql,cs,3
        %>

        <div class="container">
            <div class="row my-4">
                <form action="phones.html" method="post" class="form-inline w-100 justify-content-center">
                    <a href="./default.asp" class="mr-3 navbar-brand font-expletus">Mobile World</a>
                    <div class="input-group mr-3" style="width:60%">
                        <input type="text" class="form-control" placeholder="Search for phones" aria-label="Input group example" aria-describedby="btnGroupAddon">
                        <div class="input-group-append">
                            <button class="btn btn-info" id="btnGroupAddon">Search</button>
                        </div>
                    </div>
                    <a href="" class="btn btn-info">
                        <i class="fas fa-cart-plus mr-2"></i>Shopping Cart
                    </a>
                </form>
            </div>

            <div class="row">
                <form action="phone.asp" id="view_phone" method="get"></form>
                <form action="accessory.asp" id="view_accessory" method="get"></form>
                <form action="./action/delete_cart_item.asp" id="delete_cart_item" method="post"></form>
                <form action="./action/place_order.asp" method="post" class="w-100">
                    <table class="table">
                        <tr>
                            <th>Image</th>
                            <th>Description</th>
                            <th>Original Price</th>
                            <th>Final Price</th>
                            <th>Quantity</th>
                            <th>Action</th>
                        </tr>

                        <%do until rs.EOF%>
                        <tr>
                            <td>
                                <button type="submit" name="product_id" value="<%=rs.fields(8)%>" form="<%if rs.fields(4)="Smartphone                                        " then%>view_phone" <%else%> view_accessory" <%end if%>>
                                    <img src="<%=rs.fields(0)%>" style="width:150px">
                                </button>
                            </td>
                            <td>
                                <input name="product_id" value="<%=rs.fields(8)%>" hidden>
                                <input name="vendor_id" value="<%=rs.fields(10)%>" hidden>
                                <input name="order_item_price" value="<%=rs.fields(5)*rs.fields(6)%>" hidden>
                                <p><%=rs.fields(1).name&": "&rs.fields(1)%></p>
                                <p><%=rs.fields(2).name&": "&rs.fields(2)%></p>
                                <p><%=rs.fields(3).name&": "&rs.fields(3)%></p>
                                <p><%=rs.fields(4).name&": "&rs.fields(4)%></p>
                            </td>
                            <td><%="$ "&rs.fields(5)%></td>

                            <td><%="$ "&rs.fields(5)*rs.fields(6)&" ("&rs.fields(6)*100&"%)"%></td>
                            <td>
                                <input class="form-control" type="number" name="quantity" value="<%=rs.fields(7)%>">
                            </td>
                            <td>
                                <button class="btn" name="delete" value="<%=rs.fields(9)%>" form="delete_cart_item">Delete</button>
                            </td>
                        </tr>
                        <%
                            total_price=total_price+rs.fields(5)*rs.fields(6)
                            rs.MoveNext
                            loop
                            rs.close
                        %>

                        <%
                            sql="SELECT CUSTOMER_COUNTRY FROM CUSTOMER WHERE CUSTOMER_ID='"&Application("customer_id")&"'"
                            rs.open sql,cs,3
                            customer_country=rs.fields(0)
                            rs.close
                            
                            sql="SELECT SHIPMENTMETHOD_CODE,PROVIDER_NAME,PRICE_SHIPMENT FROM SHIPMENT WHERE COUNTRY_TO='"&customer_country&"'"
                            rs.open sql,cs,3
                        %>
                    </table>
                    <ul class="list-group mt-3">
                        <li class="list-group-item bg-primary text-white">
                            <div class="row">
                                <div class="form-row align-items-center">
                                    <div class="col-auto">
                                    Shipment:
                                    </div>
                                    <div class="col-auto">
                                        <select class="form-control form-inline" name="shipment_method_code">
                                            <%do until rs.EOF%>
                                            <option value="<%=rs.fields(0)%>"><%=rs.fields(1)&" $"&rs.fields(2)%></option>
                                            <%
                                                rs.MoveNext
                                                Loop
                                            %>
                                        </select>
                                    </div>
                                    <div class="col-auto">
                                        <input class="form-control" placeholder="Type in your order message" name="order_detail" style="width: 300px">
                                    </div>
                                </div>
                                <div class="row ml-auto mr-3">
                                    <h3 class="my-0 mx-2 font-weight-bold pr-3">Total: $<%=total_price%></h3>
                                    <button type="submit" class="btn btn-success">Order Now</button>
                                </div>
                            </div>
                        </li>
                    </ul>
                </form>
            </div>
        </div>

        <footer class="text-muted bg-secondary mt-5 p-3">
            <div class="container text-white">
                <p>Album example is © Bootstrap, but please download and customize it for yourself!</p>
            </div>
        </footer>
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
    </body>

</html>