<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar fixed-top navbar-expand-lg navbar-light bg-white">
    <a class="navbar-brand ml-2" href="index.jsp"><strong>Not Elon-chan's Electric Car Company</strong></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
        <ul class="navbar-nav mL-auto">
            <li class="nav-item">
                <a class="mr-4" href="listprod.jsp">Products</a>
            </li>
            <li class="nav-item">
                <a class="mr-4" href="showcart.jsp">Shopping Cart</a>
            </li>
            <%
                String userLoggedIn = (String)session.getAttribute("authenticatedUser");

                if (userLoggedIn == null) {
                    out.println("<li class=nav-item>" +
                                "    <a class=mr-4 href=login.jsp>Login</a>" +
                                "</li>");
                } else {
                    out.println("<li class=nav-item>" +
                                "<div class=mr-4>Welcome, <a href=customer.jsp>" + userLoggedIn + "</a>!</div>" +
                                "</li>" + 
                                "<li class=nav-item>" +
                                "<a class=mr-4 href=logout.jsp>Logout</a>" +
                                "</li>");
                }
            %>
        </ul>
    </div>
</nav>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>

</body>
</html>
