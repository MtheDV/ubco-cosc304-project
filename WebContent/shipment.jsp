<!DOCTYPE html>
<html>
<head>
<title>Grocery CheckOut Line</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"  rel="stylesheet">
</head>
<body style="padding-top: 45px">
    <%@include file="header.jsp" %>
    <%@ include file="auth.jsp" %>

    <div class="container text-center mt-5">
        <h1 class="mb-4">Enter your shipment information:</h1>

        <div class="row justify-content-center"> 
            <div class="col-4">
                <form method="get" action="addShipment.jsp">
                    <table class="mb-4">
                        <tr><td>Address:</td><td><input class="form-control mr-2" type="text" name="address" size="50"></td></tr>
                        <tr><td>City:</td><td><input class="form-control mr-2" type="text" name="city" size="40"></td></tr>
                        <tr><td>State:</td><td><input class="form-control mr-2" type="text" name="state" size="20"></td></tr>
                        <tr><td>Postal Code:</td><td><input class="form-control mr-2" type="text" name="pc" size="20"></td></tr>
                        <tr><td>Country:</td><td><input class="form-control mr-2" type="text" name="country" size="40"></td></tr>
                    </table>
                    <input class="btn btn-outline-success my-2 my-sm-0 mr-2" type="submit" value="Submit">
                    <input class="btn btn-outline-success my-2 my-sm-0 mr-2" type="reset" value="Reset">
                </form>
            </div>
        </div>
    </div>
</body>
</html>



