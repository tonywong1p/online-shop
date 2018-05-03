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
            sql="SELECT USER_NAME,PASSWORD,GENDER,BIRTHDAY,FIRST_NAME,LAST_NAME,PHONE_NO,EMAIL,CUSTOMER_ADDRESS,CUSTOMER_COUNTRY FROM CUSTOMER C "&_
            "INNER JOIN USERACCOUNT U ON C.CUSTOMER_ID=U.CUSTOMER_ID "&_
            "WHERE C.CUSTOMER_ID='"&Application("customer_id")&"'"
            rs.open sql,cs,3
        %>

        <div class="container">
            <div class="row justify-content-center my-3">
                <div class="col-8">
                    <h4>Personal Profile</h4>
                    <div class="card p-3">
                        <form action="./action/profile_update.asp" method="post">
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username"><%=rs.fields(0).name%></label>
                                    <input type="text" class="form-control form-control-sm" name="username" value="<%=rs.fields(0)%>" disabled>
                                </div>
                                <div class="col-6">
                                    <label for="username"><%=rs.fields(1).name%></label>
                                    <input type="password" class="form-control form-control-sm" name="password" value="<%=rs.fields(1)%>" required>
                                </div>
                                <div class="col-6">
                                    <label for="gender"><%=rs.fields(2).name%></label>
                                    <select class="form-control form-control-sm" id="gender" name="gender" required>
                                        <option value="M" <%if rs.fields(2)="M" then%> selected <%end if%>>Male</option>
                                        <option value="F" <%if rs.fields(2)="F" then%> selected <%end if%>>Female</option>
                                        <option value="O" <%if rs.fields(2)="O" then%> selected <%end if%>>Other</option>
                                    </select>
                                </div>
                                <div class="col-6">
                                    <label for="birthday"><%=rs.fields(3).name%></label>
                                    <input type="date" class="form-control form-control-sm" name="brithday" value="<%=rs.fields(3)%>" required>
                                </div>
                                <div class="col-6">
                                    <label for="first_name"><%=rs.fields(4).name%></label>
                                    <input type="text" class="form-control form-control-sm" name="first_name" value="<%=rs.fields(4)%>" required>
                                </div>
                                <div class="col-6">
                                    <label for="last_name"><%=rs.fields(5).name%></label>
                                    <input type="text" class="form-control form-control-sm" name="last_name" value="<%=rs.fields(5)%>" required>
                                </div>
                                <div class="col-6">
                                    <label for="last_name"><%=rs.fields(6).name%></label>
                                    <input type="text" class="form-control form-control-sm" name="phone_no" value="<%=rs.fields(6)%>" required>
                                </div>
                                <div class="col-6">
                                    <label for="last_name"><%=rs.fields(7).name%></label>
                                    <input type="text" class="form-control form-control-sm" name="email" value="<%=rs.fields(7)%>" required>
                                </div>
                                <div class="col-6">
                                    <label for="last_name"><%=rs.fields(8).name%></label>
                                    <input type="text" class="form-control form-control-sm" name="address" value="<%=rs.fields(8)%>" required>
                                </div>
                                <div class="col-6">
                                    <label for="country"><%=rs.fields(9).name%></label>
                                    <%
                                        temp=rs.fields(4)
                                        rs.close
                                        sql="SELECT DISTINCT COUNTRY_TO FROM SHIPMENT"
                                        rs.open sql,cs,3
                                    %>
                                    <select class="form-control form-control-sm" id="country" name="country" required>
                                        <%do until rs.EOF%>
                                        <option value="<%=rs.fields(0)%>" <%if rs.fields(0)=temp then%> selected <%end if%>><%=rs.fields(0)%></option>
                                        <%
                                            rs.MoveNext
                                            loop
                                            rs.close
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="float-right">
                                <button class="btn btn-primary" type="submit">Update
                                </button>
                                <a class="btn btn-secondary" href="./profile.asp">Restore</a>
                            </div>
                        </form>
                    </div>
                </div>
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