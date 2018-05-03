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

        <div class="container">
            <div class="row justify-content-center my-3">
                <div class="col-8">
                    <h4>Create New Phone</h4>
                    <h5>Step2: Input your Phone details</h5>
                    <div class="card p-3">
                        <form action="./action/vendor_add_phone.asp" method="post">
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username">Brand Name</label>
                                    <input type="text" class="form-control form-control-sm" name="brand_name" value="<%=Request.form("brand_name")%>">
                                </div>
                                <div class="col-6">
                                    <label for="email">Brand Image URL</label>
                                    <input type="text" class="form-control form-control-sm" name="brand_image_url" value="<%=Request.form("brand_image_url")%>">
                                </div>
                            </div>

                            <hr>

                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username">Product Name</label>
                                    <input type="text" class="form-control form-control-sm" name="product_name" placeholder="Enter product name" required>
                                </div>
                                <div class="col-6">
                                    <label for="email">Product Image URL</label>
                                    <input type="text" class="form-control form-control-sm" name="product_image_url" placeholder="Enter URL" required>
                                </div>
                            </div>

                            <hr>

                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username">Chipset</label>
                                    <input type="text" class="form-control form-control-sm" name="chipset" placeholder="Enter a ChipSet Type" required>
                                </div>
                                <div class="col-6">
                                    <label for="email">Display</label>
                                    <input type="number" step=".1" class="form-control form-control-sm" name="display" placeholder="Enter a number in inch" required>
                                </div>
                            </div>
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username">Camera</label>
                                    <input type="text" class="form-control form-control-sm" name="camera" placeholder="Enter a Camera type" required>
                                </div>
                                <div class="col-6">
                                    <label for="email">Battery</label>
                                    <input type="number" class="form-control form-control-sm" name="battery" placeholder="Enter a number in mAH" required>
                                </div>
                            </div>
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username">Operating System</label>
                                    <input type="text" class="form-control form-control-sm" name="os" placeholder="Enter a OS type" required>
                                </div>
                                <div class="col-6">
                                    <label for="email">Sim Slot</label>
                                    <input type="text" class="form-control form-control-sm" name="sim_slot" placeholder="Enter a Sim slot type" required>
                                </div>
                            </div>
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username">Thickness</label>
                                    <input type="number" step=".1" class="form-control form-control-sm" name="thickness" placeholder="Enter a number in mm" required>
                                </div>
                                <div class="col-6">
                                    <label for="email">Width</label>
                                    <input type="number" step=".1" class="form-control form-control-sm" name="width" placeholder="Enter a number in mm" required>
                                </div>
                            </div>
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username">Weight</label>
                                    <input type="number" class="form-control form-control-sm" name="weight" placeholder="Enter a number in g" required>
                                </div>
                                <div class="col-6">
                                    <label for="email">Height</label>
                                    <input type="number" class="form-control form-control-sm" name="height" placeholder="Enter a number in g" required>
                                </div>
                            </div>
                            <hr>
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username">Color</label>
                                    <input type="text" class="form-control form-control-sm" name="color" placeholder="Enter color" required>
                                </div>
                                <div class="col-6">
                                    <label for="email">Capacity</label>
                                    <input type="number" class="form-control form-control-sm" name="capacity" placeholder="Enter a number in GB" required>
                                </div>
                            </div>
                            <hr>
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="username">Stock Quantity</label>
                                    <input type="number" class="form-control form-control-sm" name="stock" placeholder="Enter a quantiy number" required>
                                </div>
                                <div class="col-6">
                                    <label for="email">Price</label>
                                    <input type="number" class="form-control form-control-sm" name="price" placeholder="Enter a price" required>
                                </div>
                            </div>
                            <div class="form-group form-row">
                                <div class="col-6">
                                    <label for="email">Discount</label>
                                    <input type="number" min="0" max="1" step="0.01" class="form-control form-control-sm" name="discount" placeholder="Enter a number from 0 to 1" required>
                                </div>
                            </div>

                            <div class="float-right">
                                <a class="btn btn-secondary" href="./vendor_new_phone_1.asp">Back</a>
                                <button class="btn btn-primary">Submit</button>
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