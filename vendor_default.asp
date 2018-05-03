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

        <div class="container-fluid">
            <div class="row mt-3">
                <div class="col">
                    <div class="row my-2">
                        <div class="col">
                            <h2 class="my-0">Phones</h2>
                        </div>
                        <a href="./vendor_new_phone_1.asp" class="btn btn-success ml-auto mr-3"><i class="fas fa-plus mr-1"></i>Add New</a>
                    </div>
                    <form class="card p-4 m-0" action="vendor_default.asp" method="post" id="search">
                        <div class="form-row">
                            <div class="col-2 mb-3">
                                <label for="brandSearch">
                                    <span class="font-weight-bold">Brand</span>
                                </label>
                                <select class="form-control form-control-sm" name="brand">
                                    <option value="">All Brand</option>
                                    <%
                                        sql = "SELECT BRAND_NAME FROM PRICEANDSTOCK d INNER JOIN"
                                        sql = sql & " (SELECT BRAND_NAME,PRODUCT_ID,CATEGORY_CODE FROM PRODUCT a INNER JOIN BRAND b ON a.BRAND_ID=b.BRAND_ID) c"
                                        sql = sql & " ON d.PRODUCT_ID = c.PRODUCT_ID WHERE d.VENDOR_ID = '" & Application("vendor_id") & "'"
                                        sql = sql & " AND CATEGORY_CODE = 'S_P'"
                                        sql = sql & " GROUP BY BRAND_NAME"
                                        
                                        rs.open sql,cs,3
                                        do until rs.EOF
                                            for each x in rs.Fields
                                    %>
                                    <option value="<%=x.value%>" <%if x.value=Request.Form("brand") then%> selected <%end if%>><%=x.value%></option>
                                    <%
                                        
                                        next
                                        rs.Movenext
                                        loop
                                        rs.close
                                    %>
                                </select>
                            </div>
                            <div class="col-2 mb-3">
                                <label for="colorSearch">
                                    <span class="font-weight-bold">Color</span>
                                </label>
                                <select class="form-control form-control-sm" name="color">
                                    <option value="">All Color</option>
                                    <%
                                        sql = "SELECT COLOR FROM PHONE a INNER JOIN PRICEANDSTOCK b"
                                        sql = sql & " ON a.PRODUCT_ID = b.PRODUCT_ID AND"
                                        sql = sql & " VENDOR_ID ='" & Application("vendor_id") & "'"
                                        sql = sql & " GROUP BY COLOR"
                                        
                                        rs.open sql,cs,3
                                        do until rs.EOF
                                            for each x in rs.Fields
                                    %>
                                    <option value="<%=x.value%>" <%if x.value=Request.Form("color") then%> selected <%end if%>><%=x.value%></option>
                                    <%
                                        
                                        next
                                        rs.Movenext
                                        loop
                                        rs.close
                                    %>
                                </select>
                            </div>
                            <div class="col-2 mb-3">
                                <label for="weightSearch">
                                    <span class="font-weight-bold">Capacity</span>
                                </label>
                                <select class="form-control form-control-sm" name="capacity">
                                    <option value="">All Capacity</option>
                                    <%
                                        sql = "SELECT CAPACITY FROM PHONE a INNER JOIN PRICEANDSTOCK b"
                                        sql = sql & " ON a.PRODUCT_ID = b.PRODUCT_ID AND"
                                        sql = sql & " VENDOR_ID ='" & Application("vendor_id") & "'"
                                        sql = sql & " GROUP BY CAPACITY"
                                        rs.open sql,cs,3
                                        do until rs.EOF
                                            for each x in rs.Fields
                                    %>
                                    <option value="<%=x.value%>" <%if x.value=Request.Form("capacity") then%> selected <%end if%>><%=x.value%></option>
                                    <%
                                        
                                        next
                                        rs.Movenext
                                        loop
                                        rs.close
                                    %>
                                </select>
                            </div>
                            <div class="col-2 mb-3">
                                <label for="weightSearch">
                                    <span class="font-weight-bold">Model</span>
                                </label>
                                <select class="form-control form-control-sm" name="phone_modelcode">
                                    <option value="">All Model</option>
                                    <%
                                        sql = "SELECT PHONE_MODELCODE FROM PHONE a INNER JOIN PRICEANDSTOCK b"
                                        sql = sql & " ON a.PRODUCT_ID = b.PRODUCT_ID AND"
                                        sql = sql & " VENDOR_ID ='" & Application("vendor_id") & "'"
                                        sql = sql & " GROUP BY PHONE_MODELCODE"
                                        rs.open sql,cs,3
                                        do until rs.EOF
                                            for each x in rs.Fields
                                    %>
                                    <option value="<%=x.value%>" <%if x.value=Request.Form("phone_modelcode") then%> selected <%end if%>><%=x.value%></option>
                                    <%
                                        next
                                        rs.Movenext
                                        loop
                                        rs.close
                                    %>
                                </select>
                            </div>
                            <div class="col-2 mb-3">
                                <label for="priceSearch">
                                    <span class="font-weight-bold">Price Below</span>
                                </label>
                                <input type="number" value="<%=Request.Form("price")%>" class="form-control form-control-sm" id="priceSearch" name="price" placeholder="Enter a Price Below">
                            </div>
                            <div class="col-1 mb-3">
                                <label for="stock">
                                    <span class="font-weight-bold">Stock Below</span>
                                </label>
                                <input type="number" value="<%=Request.Form("stock")%>" class="form-control form-control-sm" id="stock" name="stock" placeholder="Enter a Stock Below">
                            </div>
                            <div class="col-1 mb-3">
                                <label for="discount">
                                    <span class="font-weight-bold">Discount?</span>
                                </label>
                                <select class="form-control form-control-sm" name="discount">
                                    <option value="">All</option>
                                    <option value="1" <%if "1" = Request.Form("discount") then%> selected <%end if%>>Yes</option>
                                    <option value="0" <%if "0" = Request.Form("discount") then%> selected <%end if%>>No</option>
                                </select>
                            </div>
                            <div class="col">
                                <button class="btn btn-primary" style="width: 105px" type="submit" form="search">Search</button>
                                <button class="btn btn-link" style="width: 105px" type="submit" form="clear">Clear All</button>
                            </div>
                        </div>
                    </form>
                    <form class="m-0" action="./vendor_default.asp" method="post" id="clear">
                    </form>
                </div>
            </div>
        </div>

        <%
            if Request.Form("brand") <> "" then
                brand_filter = " AND BRAND_NAME = '" & Request.Form("brand") & "'"
            else
                brand_filter = ""
            end if
            
            if Request.Form("color") <> "" then
                color_filter = " AND COLOR = '" & Request.Form("color") & "'"
            else
                color_filter = ""
            end if
            
            if Request.Form("capacity") <> "" then
                capacity_filter = " AND CAPACITY = '" & Request.Form("capacity") & "'"
            else
                capacity_filter = ""
            end if
            
            if Request.Form("phone_modelcode") <> "" then
                model_filter = " AND A.PHONE_MODELCODE = '" & Request.Form("phone_modelcode") & "'"
            else
                model_filter = ""
            end if
            
            if Request.Form("price") <> empty then
                price_filter = " AND PRICE < " & Request.Form("price")
            else
                price_filter = ""
            end if
            
            if Request.Form("stock") <> empty then
                stock_filter = " AND STOCK_QUANTITY < " & Request.Form("stock")
            else
                stock_filter = ""
            end if
            
            if Request.Form("discount") = "1" then
                discount_filter = " AND NOT DISCOUNT = 1 "
            end if

            if Request.Form("discount") = "0" then
                discount_filter = " AND DISCOUNT = 1 "
            end if
            
            sql = "SELECT PRODUCT_IMAGE_URL,PRODUCT_NAME,BRAND_NAME,PRODUCT_ID,COLOR,CAPACITY,STOCK_QUANTITY,PRICE,DISCOUNT,PRODUCT_IMAGE_URL FROM PHONEMODEL A INNER JOIN"
            sql = sql & "  (SELECT PRICEANDSTOCK.PRODUCT_ID,PRICEANDSTOCK.PRICE,PRICEANDSTOCK.DISCOUNT,"
            sql = sql & "PRICEANDSTOCK.STOCK_QUANTITY,VENDOR.*,C.PRODUCT_NAME,C.PRODUCT_IMAGE_URL,C.CATEGORY_NAME,"
            sql = sql & "PHONE.COLOR,PHONE.CAPACITY,PHONE.PHONE_MODELCODE,C.BRAND_NAME"
            sql = sql & " FROM (((PRICEANDSTOCK INNER JOIN VENDOR ON"
            sql = sql & " PRICEANDSTOCK.VENDOR_ID=VENDOR.VENDOR_ID) INNER JOIN"
            sql = sql & " (SELECT PRODUCT.*,BRAND.BRAND_NAME,CATEGORY.CATEGORY_NAME"
            sql = sql & " FROM ((PRODUCT INNER JOIN BRAND ON PRODUCT.BRAND_ID=BRAND.BRAND_ID)"
            sql = sql & " INNER JOIN CATEGORY ON PRODUCT.CATEGORY_CODE=CATEGORY.CATEGORY_CODE)) C"
            sql = sql & " ON PRICEANDSTOCK.PRODUCT_ID=C.PRODUCT_ID)"
            sql = sql & " INNER JOIN PHONE ON PRICEANDSTOCK.PRODUCT_ID=PHONE.PRODUCT_ID)) B ON"
            sql = sql & " A.PHONE_MODELCODE=B.PHONE_MODELCODE"
            sql = sql & " WHERE 1=1" & color_filter & capacity_filter & brand_filter & stock_filter & price_filter & discount_filter & model_filter
            sql = sql & " AND VENDOR_ID = '" & Application("vendor_id") & "' "&_
            "ORDER BY PRODUCT_ID DESC"
            
            rs.open sql,cs,3
        %>

        <div class="container-fluid">
            <div class="card my-3">
                <table class="table table-sm table-striped my-0 w-100">
                    <tr>
                        <th>Image</th>
                        <th>Product ID</th>
                        <th>Product</th>
                        <th>Color</th>
                        <th>Capacity</th>
                        <th>Stock</th>
                        <th>Price</th>
                        <th>Discount</th>
                        <th>Final Price</th>
                        <th>Action</th>
                    </tr>

                    <%do until rs.EOF%>
                    <form action="./action/vendor_handle_phones.asp" method="post">
                    <tr>
                        <td>
                            <button form="vendor_phone" type="submit" name="product_id" value="<%=rs.fields(3)%>">
                                <img src="<%=rs.fields(0)%>" style="width:120px">
                            </button>
                        </td>
                        <td><%=rs.fields(3)%></td>
                        <td>
                            <p><%=rs.fields(1)%></p>
                            <p>Brand: <%=rs.fields(2)%></p>
                            <input name="product_id" value="<%=rs.fields(3)%>" hidden>
                        </td>
                        <td><%=rs.fields(4)%></td>
                        <td><%=rs.fields(5)%></td>
                        <td>
                            <input value="<%=rs.fields(6)%>" name="stock" class="form-control" style="width: 150px">
                        </td>
                        <td>
                            <input value="<%=rs.fields(7)%>" name="price" class="form-control" style="width: 150px">
                        </td>
                        <td>
                            <input value="<%=rs.fields(8)%>" name="discount" class="form-control" style="width: 150px">
                        </td>
                        <td>$<%=rs.fields(7)*rs.fields(8)%></td>
                        <td>
                            <button type="submit" name="submit" value="update" class="btn btn-primary btn-sm">Update</button>
                            <button type="submit" name="submit" value="delete" class="btn btn-warning btn-sm">Delete</button>
                        </td>
                    </tr>
                    </form>
                    <%
                        rs.MoveNext
                        loop
                    %>
                    <form id="vendor_phone" action="./vendor_phone.asp"></form>
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
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
    </body>

</html>