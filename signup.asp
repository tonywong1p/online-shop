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
            <a class="navbar-brand" href="./default.asp">Mobile World</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </nav>

        <div class="container">
            <div class="row justify-content-center my-3">
                <div class="col-8">
                    <h4>Sign Up Now</h4>
                    <div class="card p-3">
                        <form action="./action/register.asp" method="post">
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username">First Name</label>
                                    <input type="text" class="form-control form-control-sm" id="first_name" name="first_name" placeholder="Enter first name" required>
                                </div>
                                <div class="col-6">
                                    <label for="email">Last Name</label>
                                    <input type="text" class="form-control form-control-sm" id="last_name" name="last_name" placeholder="Enter last name" required>
                                </div>
                            </div>
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control form-control-sm" id="username" name="username" placeholder="Enter Username" required>
                                </div>
                                <div class="col-6">
                                    <label for="email">Email</label>
                                    <input type="text" class="form-control form-control-sm" id="email" name="email" placeholder="Enter Email" required>
                                </div>
                            </div>
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control form-control-sm" id="password" name="password" placeholder="Enter Password" required>
                                </div>
                                <div class="col-6">
                                    <label for="confirm_password">Confirm Password</label>
                                    <input type="password" class="form-control form-control-sm" id="confirm_password" name="confirm_password" placeholder="Enter Password again" required>
                                </div>
                            </div>
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="birthday">Birthday</label>
                                    <input type="date" class="form-control form-control-sm" id="birthday" name="birthday" required>
                                </div>
                                <div class="col-6">
                                    <label for="gender">Gender</label>
                                    <select class="form-control form-control-sm" id="gender" name="gender" required>
                                        <option value="M">Male</option>
                                        <option value="F">Female</option>
                                        <option value="O">Other</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="phone_no">Phone Number</label>
                                    <input type="text" class="form-control form-control-sm" id="phone_no" name="phone_no" placeholder="Enter Mobile No." required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="address">Address</label>
                                <input type="text" class="form-control form-control-sm" id="address1" name="address1" placeholder="Address Line 1" required>
                                <input type="text" class="form-control form-control-sm mt-1" id="address2" name="address2" placeholder="Address Line 2">
                                <input type="text" class="form-control form-control-sm mt-1" id="address3" name="address3" placeholder="City, District">
                                <%
                                    sql="SELECT DISTINCT COUNTRY_TO FROM SHIPMENT"
                                    rs.open sql,cs,3
                                %>

                                <select class="form-control form-control-sm mt-1" id="country" name="country" required>
                                    <%do until rs.EOF%>
                                    <option><%=rs.fields(0)%></option>
                                    <%
                                        rs.MoveNext
                                        loop
                                    %>
                                </select>
                            </div>
                            <div class="float-right">
                                <button class="btn btn-primary">Sign up
                                </button>
                                <a class="btn btn-secondary" href="./default.asp">Back</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </div>
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
    </body>

</html>