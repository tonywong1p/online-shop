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


        <div class="container">
            <div class="row my-4">
                <form action="phones.asp" method="get" class="form-inline w-100 justify-content-center">
                    <a href="./default.asp" class="mr-3 navbar-brand font-expletus">Mobile World</a>
                    <div class="input-group mr-3" style="width:600px">
                        <input type="text" class="form-control" name="search" placeholder="Search for phones" aria-label="Input group example" aria-describedby="btnGroupAddon">
                        <div class="input-group-append">
                            <button class="btn btn-info" id="btnGroupAddon">Search</button>
                        </div>
                    </div>
                    <%
                        if Application("loggedIn")=1 then
                    %>
                    <a href="./cart.asp" class="btn btn-info">
                        <i class="fas fa-cart-plus mr-2"></i>Shopping Cart
                    </a>
                    <%end if%>
                </form>
            </div>

            <%
                sql="SELECT ORDER_ID FROM CUST_ORDER "&_
                "WHERE CUSTOMER_ID='"&Application("customer_id")&"' "&_
                "ORDER BY ORDER_ID DESC"
                rs.open sql,cs,3
                
                do until rs.EOF
                    order_id=order_id&","&rs.fields(0)
                rs.MoveNext
                Loop
                rs.close
                order_id=Split(order_id,",")
                
                Dim paid(100)
                
                'Check if paid
                for i = 1 to UBound(order_id)
                    sql="SELECT PAYMENT_ID FROM PAYMENT WHERE ORDER_ID='"&order_id(i)&"'"
                    rs.open sql,cs,3
                    if rs.RecordCount > 0 then
                        paid(i)=1
                    else
                        paid(i)=0
                    end if
                    rs.close
                Next
            %>



            <%for i = 1 to UBound(order_id)%>

            <%
                sql="SELECT P.PRODUCT_IMAGE_URL,V.VENDOR_ID,V.VENDOR_NAME,V.VENDOR_ADDRESS,P.PRODUCT_ID,P.PRODUCT_NAME,QUANTITY,ORDERITEM_PRICE,DELIVERY_STATUS,DELIVERY_MSG,V.VENDOR_TELE,ORDER_DATE FROM ORDER_ITEM OI "&_
                "INNER JOIN VENDOR V ON OI.VENDOR_ID=V.VENDOR_ID "&_
                "INNER JOIN PRODUCT P ON OI.PRODUCT_ID=P.PRODUCT_ID "&_
                "INNER JOIN DELIVERY D ON D.ORDERITEM_ID=OI.ORDERITEM_ID "&_
                "INNER JOIN CUST_ORDER CO ON CO.ORDER_ID=OI.ORDER_ID "&_
                "WHERE CUSTOMER_ID='"&Application("customer_id")&"' AND OI.ORDER_ID='"&order_id(i)&"' "
                
                rs.open sql,cs,3
            %>

            <div class="modal fade" id="modal<%=i%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Make a Payment</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="payment" action="./action/place_payment.asp" method="post">
                                <input value="<%=order_id(i)%>" class="form-control" name="order_id" hidden>
                                <p>Payment method:</p>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="payment_type" value="visa" checked="checked">
                                    <label class="form-check-label" for="inlineRadio1">
                                        <img src="./image/visa.jpg" style="width: 150px">
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="payment_type" value="mastercard">
                                    <label class="form-check-label" for="inlineRadio2">
                                        <img src="./image/mastercard.jpg" style="width: 150px">
                                    </label>
                                </div>
                                <div class="row mt-3">
                                    <div class="ml-auto mr-2">
                                        <button type="submit" class="btn btn-primary">Confirm</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </form>
                        </div>


                    </div>
                </div>
            </div>

            <div class="card row my-3">
                <div class="row p-2">
                    <div class="ml-auto mr-3">
                        <span class="mr-2">Order Date: <%=rs.fields(11)%></span>
                        <%if paid(i)=0 then%>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#modal<%=i%>">Make Payment</button>
                        <%else%>
                        <span class="font-weight-bold text-success" style="font-size: 20px">Paid</span>
                        <%end if%>
                    </div>
                </div>
                <table class="table">
                    <tr>
                        <th>Image</th>
                        <th>Product</th>
                        <th>Vendor</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                    <%do until rs.EOF%>
                    <tr>
                        <td>
                            <img src="<%=rs.fields(0)%>" style="width: 150px">
                        </td>
                        <td>
                            <p><%=rs.fields(5)%></p>
                            <p>ID: <%=rs.fields(4)%></p>
                        </td>
                        <td>
                            <p><%=rs.fields(2)%></p>
                            <p>Address: <%=rs.fields(3)%></p>
                            <p>Phone: <%=rs.fields(10)%></p>
                            <p>ID: <%=rs.fields(1)%></p>
                        </td>
                        <td><%=rs.fields(6)%></td>
                        <td>$<%=rs.fields(7)%></td>
                        <td>
                            <%
                                if rs.fields(8)=False then
                                Response.write("<p class='text-danger'>Not delivered</p>")
                                else
                                Response.write("<p class='text-success'>Delivered</p>")
                                end if
                            %>
                            <p>Msg: <%=rs.fields(9)%></p>
                        </td>
                    </tr>
                    <%
                        rs.MoveNext
                        loop
                    %>
                </table>
            </div>

            <%
                rs.close
                Next
            %>
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