<!DOCTYPE html>
<html>
<head>
        <title>Not Elon-chan's Electric Cars Main Page</title>
</head>
<body style="margin:0;height:100%;overflow:hidden;padding-top: 45px">
<%@include file="header.jsp"%>

<video style="position: absolute;width: 100%;top:0;left:0;padding-top:-45px;z-index: 0;" width="720" autoplay muted loop playsinline>
        <source src="vid/Car.mp4" type="video/mp4">
        Unsupported Video.
</video>

<img style="position:absolute;width:100%;" src="img/transparent.svg">

<div style="position: relative;z-index: 2;">
        <br><br><br>
        <h1 class="mt-5 mb-5" align="center"><strong>Welcome to Not Elon-chan's Electric Car Company</strong></h1>
        <br><br>

        <!-- <h2 align="center"><a href="login.jsp">Login</a></h2> -->

        <div class="text-center mt-3"><a class="btn btn-lg btn-light" href="listprod.jsp">Begin Shopping</a></div>
        <div class="text-center mt-3"><a class="btn btn-lg btn-light" href="customer.jsp">Customer Info</a></div>
        <div class="text-center mt-3"><a class="btn btn-lg btn-light" href="admin.jsp">Administrators</a></div>
</div>

<!-- <h2 align="center"><a href="logout.jsp">Log out</a></h2> -->

<%
// TODO: Display user name that is logged in (or nothing if not logged in)	
%>
</body>
</head>


