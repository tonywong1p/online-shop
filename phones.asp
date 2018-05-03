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
        display=request.querystring("display")
        os=request.querystring("os")
        capacity=request.querystring("capacity")
        battery=request.querystring("battery")
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
                    <li class="breadcrumb-item active" aria-current="page">Mobile Phones</li>
                </ol>
            </nav>

            <div class="card p-3">
                <form id="submit" action="phones.asp" method="get">
                    <div class="form-row">
                        <div class="col-3 mb-3">
                            <label for="brandSearch">
                                <span class="font-weight-bold">Brand</span>
                            </label>
                            <%
                                sql="SELECT DISTINCT BRAND_NAME FROM PRODUCT P "&_
                                "INNER JOIN CATEGORY C ON P.CATEGORY_CODE=C.CATEGORY_CODE "&_
                                "INNER JOIN BRAND B ON P.BRAND_ID=B.BRAND_ID "&_
                                "INNER JOIN ("&_
                                "SELECT PHM.*,PH.PRODUCT_ID,PH.COLOR,PH.CAPACITY,PH.RELEASE_DATE FROM PHONE PH "&_ 
                                "INNER JOIN PHONEMODEL PHM ON PH.PHONE_MODELCODE=PHM.PHONE_MODELCODE"&_
                                ") PH_PHM ON P.PRODUCT_ID=PH_PHM.PRODUCT_ID"
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
                        <div class="col-3 mb-3">
                            <label for="priceSearch">
                                <span class="font-weight-bold">Price</span>
                            </label>
                            <select class="form-control form-control-sm" name="price">
                                <option value="<%=empty%>">Select Budget</option>
                                <option value="1" <%if request.querystring("price")="1" then%> selected <%end if%>>Below HK$4,000</option>
                                <option value="2" <%if request.querystring("price")="2" then%> selected <%end if%>>HK$4,000-HK$5,499</option>
                                <option value="3" <%if request.querystring("price")="3" then%> selected <%end if%>>HK$5,500-HK$6,999</option>
                                <option value="4" <%if request.querystring("price")="4" then%> selected <%end if%>>Above HK$7,000</option>
                            </select>
                        </div>
                        <div class="col-3 mb-3">
                            <label for="Search">
                                <span class="font-weight-bold">Display</span>
                            </label>
                            <select class="form-control form-control-sm" name="display">
                                <%
                                    sql="SELECT DISTINCT DISPLAY FROM PHONEMODEL"
                                    rs.open sql,cs,3
                                %>
                                <option value="<%=empty%>">Select a Display</option>
                                <%do until rs.EOF%>
                                <option value="<%=rs.fields(0)%>" <%if request.querystring("display")=rs.fields(0) then%> selected <%end if%>><%=rs.fields(0)%></option>
                                <%
                                    rs.MoveNext
                                    loop
                                    rs.close
                                %>
                            </select>
                        </div>
                        <div class="col-3 mb-3">
                            <label for="Search">
                                <span class="font-weight-bold">Operating System</span>
                            </label>
                            <select class="form-control form-control-sm" name="os">
                                <%
                                    sql="SELECT DISTINCT OPERATING_SYSTEM FROM PHONEMODEL"
                                    rs.open sql,cs,3
                                %>
                                <option value="<%=empty%>">Select a OS</option>
                                <%do until rs.EOF%>
                                <option value="<%=rs.fields(0)%>" <%if request.querystring("os")=rs.fields(0) then%> selected <%end if%>><%=rs.fields(0)%></option>
                                <%
                                    rs.MoveNext
                                    loop
                                    rs.close
                                %>
                            </select>
                        </div>
                        <div class="col-3">
                            <label for="Search">
                                <span class="font-weight-bold">Capacity</span>
                            </label>
                            <select class="form-control form-control-sm" name="capacity">
                                <%
                                    sql="SELECT DISTINCT CAPACITY FROM PHONE"
                                    rs.open sql,cs,3
                                %>
                                <option value="<%=empty%>">Select a Capacity</option>
                                <%do until rs.EOF%>
                                <option value="<%=rs.fields(0)%>" <%if request.querystring("capacity")=rs.fields(0) then%> selected <%end if%>><%=rs.fields(0)%></option>
                                <%
                                    rs.MoveNext
                                    loop
                                    rs.close
                                %>
                            </select>
                        </div>
                        <div class="col-3">
                            <label for="Search">
                                <span class="font-weight-bold">Battery</span>
                            </label>
                            <select class="form-control form-control-sm" name="battery">
                                <%
                                    sql="SELECT DISTINCT BATTERY FROM PHONEMODEL"
                                    rs.open sql,cs,3
                                %>
                                <option value="<%=empty%>">Select a Battery</option>
                                <%do until rs.EOF%>
                                <option value="<%=rs.fields(0)%>" <%if request.querystring("battery")=rs.fields(0) then%> selected <%end if%>><%=rs.fields(0)%></option>
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
                <form id="reset" action="phones.asp" method="get">
                </form>
            </div>

            <hr>

            <%
                if brand <> empty then
                    brand_filter=" AND BRAND_NAME='"&brand&"'"
                end if
                if display <> empty then
                    display_filter=" AND Display='"&display&"'"
                end if
                if os <> empty then
                    os_filter=" AND 'Operating System'='"&os&"'"
                end if
                if capacity <> empty then
                    capacity_filter=" AND Capacity='"&capacity&"'"
                end if
                if battery <> empty then
                    battery_filter=" AND Battery='"&battery&"'"
                end if
                if price = "1" then
                    price_filter=" AND MIN(PRICE) BETWEEN 0 AND 4000"
                end if
                if price = "2" then
                    price_filter=" AND MIN(PRICE) BETWEEN 4000 AND 5499"
                end if
                if price = "3" then
                    price_filter=" AND MIN(PRICE) BETWEEN 5500 AND 6999"
                end if
                if price = "4" then
                    price_filter=" AND MIN(PRICE) > 7000"
                end if
            %>

            <%
                sql="SELECT P_PH_PHM.PRODUCT_IMAGE_URL,P_PH_PHM.PRODUCT_NAME,COLOR Color,CAPACITY Capacity,OPERATING_SYSTEM 'Operating System',DISPLAY Display,"&_
                "CAMERA Camera,CHIPSET Chipset,BATTERY Battery,MIN(PRICE),MAX(PRICE),P_PH_PHM.PRODUCT_ID FROM PRICEANDSTOCK PNS "&_
                "INNER JOIN VENDOR V ON PNS.VENDOR_ID=V.VENDOR_ID "&_
                "INNER JOIN ("&_
                "SELECT PH_PHM.*,C.*,B.*,P.PRODUCT_NAME,P.PRODUCT_IMAGE_URL FROM PRODUCT P "&_
                "INNER JOIN CATEGORY C ON P.CATEGORY_CODE=C.CATEGORY_CODE "&_
                "INNER JOIN BRAND B ON P.BRAND_ID=B.BRAND_ID "&_
                "INNER JOIN ("&_
                "SELECT PHM.*,PH.PRODUCT_ID,PH.COLOR,PH.CAPACITY,PH.RELEASE_DATE FROM PHONE PH "&_
                "INNER JOIN PHONEMODEL PHM ON PH.PHONE_MODELCODE=PHM.PHONE_MODELCODE"&_
                ") PH_PHM ON P.PRODUCT_ID=PH_PHM.PRODUCT_ID"&_
                ") P_PH_PHM ON PNS.PRODUCT_ID=P_PH_PHM.PRODUCT_ID "&_
                "WHERE 1=1"&brand_filter&display_filter&os_filter&capacity_filter&battery_filter&" "&_
                "GROUP BY P_PH_PHM.PRODUCT_ID,P_PH_PHM.PRODUCT_IMAGE_URL,P_PH_PHM.PRODUCT_NAME,COLOR,CAPACITY,OPERATING_SYSTEM,DISPLAY,CAMERA,CHIPSET,BATTERY,BRAND_NAME "&_
                "HAVING 1=1"&price_filter&_
                " AND P_PH_PHM.PRODUCT_NAME like '%"&search&"%' OR BRAND_NAME like '%"&search&"%'"
                rs.open sql,cs,3
            %>

            <form action="phone.asp" method="get">
                <div class="mt-2">
                    <button class="btn btn-info mr-3" type="submit" name="submit" value="compare">Compare Models
                    </button>
                    <label class="text-primary" style="font-style: italic">Select Models to Compare!</label>
                </div>

                <% do until rs.EOF %>
                <div class="row mt-4">
                    <div class="col-2">
                        <img class="img-fluid" src="<%=rs.fields(0)%>" />
                    </div>
                    <div class="col-7">
                        <h5><%=rs.fields(1)&" "&rs.fields(2)&" "&rs.fields(3)%></h5>
                        <table class="table table-sm">
                            <tbody>
                            <tr>
                                <th><%=rs.fields(4).name%></th>
                                <td><%=rs.fields(4)%></td>
                            </tr>
                            <tr>
                                <th><%=rs.fields(5).name%></th>
                                <td><%=rs.fields(5)%></td>
                            </tr>
                            <tr>
                                <th><%=rs.fields(6).name%></th>
                                <td><%=rs.fields(6)%></td>
                            </tr>
                            <tr>
                                <th><%=rs.fields(7).name%></th>
                                <td><%=rs.fields(7)%></td>
                            </tr>
                            <tr>
                                <th><%=rs.fields(8).name%></th>
                                <td><%=rs.fields(8)%></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col">
                        <div class="float-left">
                            <h3><%="HK$"&rs.fields(9)%><%if rs.fields(9)<>rs.fields(10) then Response.write("-"&rs.fields(10)) end if%></h3>
                            <button class="btn btn-primary" type="submit" name="product_id" value="<%=rs.fields(11)%>">Learn More</button>
                            <div class="form-check mt-2">
                                <input class="form-check-input" type="checkbox" name="compare" value="<%=rs.fields(11)%>">
                                <label class="form-check-label text-primary" for="compareModels">Add to Compare</label>
                            </div>
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
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
    </body>

</html>