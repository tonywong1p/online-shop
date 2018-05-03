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
        
        product_id=Request.querystring("product_id")
        
        if Request.querystring("submit") = "compare" then
            Application.Lock
            Application("compare")=Request.querystring("compare")
            Application.Unlock
            Response.Redirect "./compare.asp"
        end if
        
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
                        <a class="nav-link" href="#">Profile</a>
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
                <a href="" class="btn btn-link text-light mr-2">Welcome! <%=Application("fullname")%></a>
                <a href="./action/logout.asp" class="btn btn-info">Logout</a>
                <%end if%>
            </div>
        </nav>

        <%
            sql="SELECT P_PH_PHM.PRODUCT_IMAGE_URL,P_PH_PHM.PRODUCT_NAME,COLOR Color,CAPACITY Capacity,OPERATING_SYSTEM 'Operating System',DISPLAY Display,"&_
            "CAMERA Camera,CHIPSET Chipset,BATTERY Battery,RELEASE_DATE 'Release Date',SIM_SLOT 'SIM Slot',"&_
            "THICKNESS Thickness, WIDTH Width, WEIGHT Weight, HEIGHT Height,P_PH_PHM.PRODUCT_ID FROM PRICEANDSTOCK PNS "&_
            "INNER JOIN ("&_
            "SELECT PH_PHM.*,C.*,B.*,P.PRODUCT_NAME,P.PRODUCT_IMAGE_URL FROM PRODUCT P "&_
            "INNER JOIN CATEGORY C ON P.CATEGORY_CODE=C.CATEGORY_CODE "&_
            "INNER JOIN BRAND B ON P.BRAND_ID=B.BRAND_ID "&_
            "INNER JOIN ("&_
            "SELECT PHM.*,PH.PRODUCT_ID,PH.COLOR,PH.CAPACITY,PH.RELEASE_DATE FROM PHONE PH "&_
            "INNER JOIN PHONEMODEL PHM ON PH.PHONE_MODELCODE=PHM.PHONE_MODELCODE"&_
            ") PH_PHM ON P.PRODUCT_ID=PH_PHM.PRODUCT_ID"&_
            ") P_PH_PHM ON PNS.PRODUCT_ID=P_PH_PHM.PRODUCT_ID "&_
            "WHERE P_PH_PHM.PRODUCT_ID='"&product_id&"'"
            rs.open sql,cs,3        
        %>

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
        </div>

        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="./default.asp">Home</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="./phones.asp">Mobile Phones</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page"><%=rs.fields(1)%></li>
                </ol>
            </nav>

            <div class="row">
                <div class="col-4">
                    <img class="img-fluid" src="<%=rs.fields(0)%>" />
                </div>
                <div class="col-8">
                    <h3><%=rs.fields(1)&" "&rs.fields(2)&" "&rs.fields(3)%></h3>
                    <div class="row">
                        <div class="col-6">
                            <table class="table table-sm">
                                <%for i = 2 to 8%>
                                <tr>
                                    <th><%=rs.fields(i).name%></th>
                                    <td><%=rs.fields(i)%></td>
                                </tr>
                                <%next%>
                            </table>
                        </div>
                        <div class="col-6">
                            <table class="table table-sm">
                                <%for i = 9 to 14%>
                                <tr>
                                    <th><%=rs.fields(i).name%></th>
                                    <td><%=rs.fields(i)%></td>
                                </tr>
                                <%next%>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <%=rs.close%>

            <hr>
            <%
                if Application("loggedIn")=1 then
                    sql="SELECT CART_ID FROM CART WHERE CUSTOMER_ID='"&Application("customer_id")&"'"
                    rs.open sql,cs,3
                    cart_id=rs.fields(0)
                    rs.close
                end if
            %>

            <%
                sql="SELECT V.VENDOR_NAME,V.VENDOR_ADDRESS,V.VENDOR_TELE Tele,PNS.PRICE,PNS.DISCOUNT,V.VENDOR_ID FROM PRICEANDSTOCK PNS "&_
                "INNER JOIN VENDOR V ON PNS.VENDOR_ID=V.VENDOR_ID "&_
                "WHERE PNS.PRODUCT_ID='"&product_id&"'"
                
                rs.open sql,cs,3
            %>


            <ul class="list-group w-100">
                <li class="list-group-item p-0">
                    <table class="table my-0">
                        <tr>
                            <th>Vendor Name</th>
                            <th>Contact Info</th>
                            <th>Price</th>
                            <th>Discounted</th>
                            <th></th>
                        </tr>
                        <%do until rs.EOF%>
                        <form action="./action/add_cart_item.asp" method="post">
                        <tr>
                            <td><%=rs.fields(0)%></td>
                            <td>
                                <p><%=rs.fields(1)%></p>
                                <p><%=rs.fields(2).name&": "&rs.fields(2)%></p>
                            </td>
                            <td><%="$"&rs.fields(3)%></td>
                            <td><%="$"&rs.fields(3)*rs.fields(4)&" ("&rs.fields(4)*100&"%)"%></td>
                            <%
                                if Application("loggedIn")=1 then
                            %>
                            <td>
                                <input name="product_id" value="<%=product_id%>" hidden>
                                <input name="vendor_id" value="<%=rs.fields(5)%>" hidden>
                                <button type="submit" class="btn btn-primary btn-sm text-white" name="cart_id" value="<%=cart_id%>">Add to Cart</button>
                            </td>
                            <%end if%>
                        </tr>
                            </form>
                        <%
                            rs.MoveNext
                            loop
                        %>
                    </table>
                </li>
            </ul>

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