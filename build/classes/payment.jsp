<!DOCTYPE html>
<html>
<head>
<title>Grocery CheckOut Line</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"  rel="stylesheet">
</head>
<body style="padding-top: 45px">
    <%@include file="header.jsp" %>

    <div class="container text-center mt-5">
        <h1 class="mb-4">Enter your payment information:</h1>

        <div class="row justify-content-center"> 
            <div class="col-4">
                <form method="get" action="addPayment.jsp">
                    <table class="mb-4">
                        <tr><td>Payment Type:</td><td><input class="form-control mr-2" type="text" name="paymentType" size="20"></td></tr>
                        <tr><td>Payment Number:</td><td><input class="form-control mr-2" type="text" name="paymentNumber" size="30"></td></tr>
                        <tr><td>Expiry Date:</td><td><input class="form-control mr-2" type="date" name="expDate"></td></tr>
                    </table>
                    <input class="btn btn-outline-success my-2 my-sm-0 mr-2" type="submit" value="Submit">
                    <input class="btn btn-outline-success my-2 my-sm-0 mr-2" type="reset" value="Reset">
                </form>
            </div>
        </div>
    </div>
</body>
</html>



