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
        
        brand=request.querystring("brand")
        category=request.querystring("category")
        color=request.querystring("color")
        price=request.querystring("price")
        search=request.querystring("search")
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

            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="./default.asp">Home</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Accessories</li>
                </ol>
            </nav>

            <div class="card p-3">
                <form id="submit" action="accessories.asp" method="get">
                    <div class="form-row">
                        <div class="col-3 mb-3">
                            <label for="brandSearch">
                                <span class="font-weight-bold">Brand</span>
                            </label>
                            <%
                                sql="SELECT DISTINCT BRAND_NAME FROM PRODUCT P "&_
                                "INNER JOIN CATEGORY C ON P.CATEGORY_CODE=C.CATEGORY_CODE "&_
                                "INNER JOIN BRAND B ON P.BRAND_ID=B.BRAND_ID "&_
                                "INNER JOIN ACCESSORY A ON P.PRODUCT_ID=A.PRODUCT_ID"
                                rs.open sql,cs,3
                            %>
                            <select class="form-control form-control-sm" name="brand">
                                <option value="<%=empty%>">Select a Brand</option>
                                <%do until rs.EOF%>
                                <option value="<%=rs.fields(0)%>" <%if request.querystring("brand")=rs.fields(0) then%> selected <%end if%>><%=rs.fields(0)%></option>
                                <%
                                    rs.MoveNext
                                    loop
                                    rs.close
                                %>
                            </select>
                        </div>
                        <%Response.write(request.querystring("price"))%>
                        <div class="col-3 mb-3">
                            <label for="priceSearch">
                                <span class="font-weight-bold">Price</span>
                            </label>
                            <select class="form-control form-control-sm" name="price">
                                <option value="<%=empty%>">Select Budget</option>
                                <option value="1" <%if request.querystring("price")="1" then%> selected <%end if%>>Below HK$500</option>
                                <option value="2" <%if request.querystring("price")="2" then%> selected <%end if%>>HK$500-HK$1,000</option>
                                <option value="3" <%if request.querystring("price")="3" then%> selected <%end if%>>HK$1,000-HK$1,500</option>
                                <option value="4" <%if request.querystring("price")="4" then%> selected <%end if%>>Above HK$1,500</option>
                            </select>
                        </div>
                        <div class="col-3 mb-3">
                            <label for="Search">
                                <span class="font-weight-bold">Category</span>
                            </label>
                            <select class="form-control form-control-sm" name="category">
                                <%
                                    sql="SELECT CATEGORY_NAME FROM CATEGORY WHERE NOT CATEGORY_NAME='Smartphone'"
                                    rs.open sql,cs,3
                                %>
                                <option value="<%=empty%>">Select a Category</option>
                                <%do until rs.EOF%>
                                <option value="<%=rs.fields(0)%>" <%if request.querystring("category")=rs.fields(0) then%> selected <%end if%>><%=rs.fields(0)%></option>
                                <%
                                    rs.MoveNext
                                    loop
                                    rs.close
                                %>
                            </select>
                        </div>
                        <div class="col-3 mb-3">
                            <label for="Search">
                                <span class="font-weight-bold">Color</span>
                            </label>
                            <select class="form-control form-control-sm" name="color">
                                <%
                                    sql="SELECT DISTINCT COLOR FROM ACCESSORY"
                                    rs.open sql,cs,3
                                %>
                                <option value="<%=empty%>">Select a Color</option>
                                <%do until rs.EOF%>
                                <option value="<%=rs.fields(0)%>" <%if request.querystring("color")=rs.fields(0) then%> selected <%end if%>><%=rs.fields(0)%></option>
                                <%
                                    rs.MoveNext
                                    loop
                                    rs.close
                                %>
                            </select>
                        </div>
                        <div class="col align-self-end">
                            <div class="float-right">
                                <button class="btn btn-primary" type="submit" form="submit">Search</button>
                                <button class="btn btn-primary" type="submit" form="reset">Clear</button>
                            </div>
                        </div>
                    </div>
                </form>
                <form id="reset" action="accessories.asp" method="get">
                </form>
            </div>

            <hr>

            <%
                if brand <> empty then
                    brand_filter=" AND BRAND_NAME='"&brand&"'"
                end if
                if category <> empty then
                    category_filter=" AND CATEGORY_NAME='"&category&"'"
                end if
                if color <> empty then
                    color_filter=" AND COLOR='"&color&"'"
                end if
                if price = "1" then
                    price_filter=" AND MIN(PRICE) BETWEEN 0 AND 500"
                end if
                if price = "2" then
                    price_filter=" AND MIN(PRICE) BETWEEN 500 AND 1000"
                end if
                if price = "3" then
                    price_filter=" AND MIN(PRICE) BETWEEN 1000 AND 1500"
                end if
                if price = "4" then
                    price_filter=" AND MIN(PRICE) > 1500"
                end if
            %>

            <%
                sql="SELECT P_A.PRODUCT_IMAGE_URL,P_A.PRODUCT_NAME,COLOR,P_A.BRAND_NAME Brand,P_A.CATEGORY_NAME Category,P_A.FEATURE Feature,MIN(PRICE),MAX(PRICE),PNS.PRODUCT_ID FROM PRICEANDSTOCK PNS "&_
                "INNER JOIN VENDOR V ON PNS.VENDOR_ID=V.VENDOR_ID "&_
                "INNER JOIN (SELECT A.*,C.*,B.*,P.PRODUCT_NAME,P.PRODUCT_IMAGE_URL FROM PRODUCT P "&_
                "INNER JOIN CATEGORY C ON P.CATEGORY_CODE=C.CATEGORY_CODE "&_
                "INNER JOIN BRAND B ON P.BRAND_ID=B.BRAND_ID "&_
                "INNER JOIN ACCESSORY A ON P.PRODUCT_ID=A.PRODUCT_ID"&_
                ") P_A ON PNS.PRODUCT_ID=P_A.PRODUCT_ID "&_
                "WHERE 1=1"&brand_filter&category_filter&color_filter&" "&_
                "GROUP BY P_A.PRODUCT_IMAGE_URL,P_A.PRODUCT_NAME,COLOR,P_A.BRAND_NAME,P_A.CATEGORY_NAME,P_A.FEATURE,PNS.PRODUCT_ID "&_
                "HAVING 1=1"&price_filter

                rs.open sql,cs,3
            %>

            <form action="accessory.asp" method="get">
                <% do until rs.EOF %>
                <div class="row mt-4">
                    <div class="col-2">
                        <img class="img-fluid" src="<%=rs.fields(0)%>" />
                    </div>
                    <div class="col-7">
                        <h5><%=rs.fields(1)&" "&rs.fields(2)%></h5>
                        <table class="table table-sm">
                            <tbody>
                            <tr>
                                <th><%=rs.fields(3).name%></th>
                                <td><%=rs.fields(3)%></td>
                            </tr>
                            <tr>
                                <th><%=rs.fields(4).name%></th>
                                <td><%=rs.fields(4)%></td>
                            </tr>
                            <tr>
                                <th><%=rs.fields(5).name%></th>
                                <td><%=rs.fields(5)%></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col">
                        <div class="float-left">
                            <h3><%="HK$"&rs.fields(6)%><%if rs.fields(6)<>rs.fields(7) then Response.write("-"&rs.fields(7)) end if%></h3>
                            <button class="btn btn-primary" type="submit" name="product_id" value="<%=rs.fields(8)%>">Learn More</button>
                        </div>
                    </div>
                    <div class="menu-divider"></div>
                </div>
                <%
                    rs.MoveNext
                    loop
                    rs.close
                %>
            </form>
        </div>




        <footer class="text-muted bg-secondary mt-5 p-3">
            <div class="container text-white">
                <p>Album example is © Bootstrap, but please download and customize it for yourself!</p>
            </div>
        </footer>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
    </body>

</html>