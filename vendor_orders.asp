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
        <nav class="navbar navbar-expand-sm navbar-light bg-dark navbar-dark">
            <a class="navbar-brand font-expletus" href="./vendor_default.asp">Mobile World</a>
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
                            <a class="dropdown-item" href="./vendor_default.asp">Mobile Phone</a>
                            <a class="dropdown-item" href="./vendor_accessories.asp">Accessory</a>
                        </div>
                    </li>
                    <%
                        if Application("loggedIn")=1 then
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="./vendor_orders.asp">Order Record</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="./vendor_profile.asp">Profile</a>
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
                <a href="./vendor_profile.asp" class="btn btn-link text-light mr-2">Welcome! <%=Application("vendor_name")%>(Admin ID: <%=Application("admin_id")%>)</a>
                <a href="./action/logout.asp" class="btn btn-info">Logout</a>
                <%end if%>
            </div>
        </nav>

        <%
            sql="SELECT P.PRODUCT_IMAGE_URL Image,P.PRODUCT_ID,P.PRODUCT_NAME,CUS.CUSTOMER_ADDRESS,QUANTITY,ORDERITEM_PRICE,ORDER_DATE,DELIVERY_MSG,DELIVERY_STATUS,OI.ORDERITEM_ID,PAY.PAYMENT_ID FROM ORDER_ITEM OI "&_
            "INNER JOIN VENDOR V ON OI.VENDOR_ID=V.VENDOR_ID "&_
            "INNER JOIN PRODUCT P ON OI.PRODUCT_ID=P.PRODUCT_ID "&_
            "INNER JOIN DELIVERY D ON D.ORDERITEM_ID=OI.ORDERITEM_ID "&_
            "INNER JOIN CUST_ORDER CO ON CO.ORDER_ID=OI.ORDER_ID "&_
            "INNER JOIN CUSTOMER CUS ON CUS.CUSTOMER_ID=CO.CUSTOMER_ID "&_
            "LEFT JOIN PAYMENT PAY ON PAY.ORDER_ID=OI.ORDER_ID "&_
            "WHERE OI.VENDOR_ID='"&Application("vendor_id")&"' "&_
            "ORDER BY OI.ORDERITEM_ID DESC"
            rs.open sql,cs,3
        %>


        <div class="row w-100">
            <div class="col">
                <table class="table">
                    <tr>
                        <th>Image</th>
                        <th>Product</th>
                        <th>Order Item ID</th>
                        <th>Customer Address</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Order Date</th>
                        <th>Payment</th>
                        <th>Message</th>
                        <th>Action</th>
                    </tr>
                    <%do until rs.EOF%>
                    <form action="./action/vendor_handle_order.asp" method="post">
                    <tr>
                        <td>
                            <img src="<%=rs.fields(0)%>" style="width: 120px">
                        </td>
                        <td>
                            <p><%=rs.fields(2)%></p>
                            <p>(ID:<%=rs.fields(1)%>)</p>
                        </td>
                        <td><%=rs.fields(9)%></td>
                        <td><%=rs.fields(3)%></td>
                        <td><%=rs.fields(4)%></td>
                        <td>$<%=rs.fields(5)%></td>
                        <td><%=rs.fields(6)%></td>
                        <td>
                            <%if rs.fields(10)<>empty then%>
                            <p class="text-success">Paid</p>
                            <%else%>
                            <p class="text-danger">Not Paid</p>
                            <%end if%>
                        </td>
                        <td>
                            <input name="product_id" value="<%=rs.fields(1)%>" hidden>
                            <input name="order_item_id" value="<%=rs.fields(9)%>" hidden>
                            <input name="status" value="<%=rs.fields(8)%>" hidden>
                            <input class="form-control" name="message" value="<%=rs.fields(7)%>">
                            <button class="btn btn-sm mt-2" type="submit" name="submit" value="update">Update</button>
                        </td>
                        <td>
                            <%if rs.fields(8)=false then%>
                            <button class="btn btn-danger" type="submit" name="submit" value="deliver" <%if rs.fields(10)<>empty then
                                    else%> disabled <%end if%>>Deliver</button>
                            <%else%>
                            <h5 class="text-success">Delivered</h5>
                            <%end if%>
                        </td>
                    </tr>
                        </form>
                    <%
                        rs.MoveNext
                        loop
                        rs.close
                    %>
                </table>
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