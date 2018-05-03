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
        
        compare=Application("compare")
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
            sql="SELECT P.PRODUCT_IMAGE_URL,P.PRODUCT_NAME,B.BRAND_NAME,PH_PHM.* FROM PRODUCT P "&_
            "INNER JOIN CATEGORY C ON P.CATEGORY_CODE=C.CATEGORY_CODE "&_
            "INNER JOIN BRAND B ON P.BRAND_ID=B.BRAND_ID "&_
            "INNER JOIN ("&_
            "SELECT PHM.*,PH.PRODUCT_ID,PH.COLOR,PH.CAPACITY,PH.RELEASE_DATE FROM PHONE PH "&_
            "INNER JOIN PHONEMODEL PHM ON PH.PHONE_MODELCODE=PHM.PHONE_MODELCODE"&_
            ") PH_PHM ON P.PRODUCT_ID=PH_PHM.PRODUCT_ID "&_
            "WHERE P.PRODUCT_ID IN ("&compare&")"
            
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

            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="./default.asp">Home</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">
                        <a href="./phones.asp">Mobile Phones</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">Compare</li>

                </ol>
            </nav>

            <div class="row">
                <table class="table table-responsive">
                    <tr>
                        <th>Image</th>
                        <%do until rs.EOF%>
                        <td><img src="<%=rs.fields(0)%>" style="width: 150px"></td>
                        <%
                            rs.MoveNext
                            loop
                            rs.MoveFirst
                        %>
                    </tr>
                    <%
                        for i = 1 to 18
                    %>
                    <%
                        if rs.fields(i).name = "PHONEMODEL_IMAGE_URL" then
                        else
                    %>
                    <th><%=rs.fields(i).name%></th>
                    <%end if%>
                    <%do until rs.EOF%>

                    <%
                        if rs.fields(i).name = "PHONEMODEL_IMAGE_URL" then
                        else
                    %>
                    <td><%=rs.fields(i)%></td>
                    <%end if%>
                    <%
                        rs.MoveNext
                        loop
                    %>
                    </tr>
                    <%
                        rs.MoveFirst
                        Next
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
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
    </body>

</html>