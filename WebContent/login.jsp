<!DOCTYPE html>
<html>
<head>
<title>Login Screen</title>
</head>
<body style="padding-top: 45px">

<%@ include file="header.jsp" %>

<div class="container mt-5 text-center">

	<%
	// Print prior error login message if present
	if (session.getAttribute("loginMessage") != null)
		out.println("<div class='alert alert-danger' role=alert>"+session.getAttribute("loginMessage").toString()+"</div>");
	%>

<h3>Please Login to System:</h3>


<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><label for="inputUsername"  align="right">Username:</label></td>
	<td><input class="form-control" id="inputUsername" type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><label for="inputPassword" align="right">Password:</label></td>
	<td><input class="form-control" id="inputUsername" type="password" name="password" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="btn btn-primary mt-5" type="submit" name="Submit2" value="Log In">
</form>

<div class='mt-3'>
	<a class="btn btn-secondary mt-1" href=createUser.jsp>Create User</a>
</div>



</div>

</body>
</html>

