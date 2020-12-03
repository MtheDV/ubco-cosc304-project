<!DOCTYPE html>
<html>
<head>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"  rel="stylesheet">
	<title>Customer Page</title>
</head>
<body style="padding-top: 45px">


<%@ include file="header.jsp" %>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<div class="container mt-5">
<%

if (userName == null){

	// Display message saying wrong user id or password
	out.println("<h4 class='text-center'> Cannot access page, you are not logged in.	" +
			"<a href='javascript:history.back()'>Go Back</a></h4>");

} else{

	// TODO: Print Customer information
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";

	//Note: Forces loading of SQL Server driver
	try{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e){
		out.println("ClassNotFoundException: " +e);
	}

	// Make connection
	try (Connection con = DriverManager.getConnection(url,uid,pw);){

		String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid"
			+" FROM customer WHERE userid = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, userName);
		ResultSet rst = stmt.executeQuery();

		out.println("<table class='table'><thead class='thead-dark'><tr><th>Customer Profile</th><th></th></thead>");

		// Print out the ResultSet
		while (rst.next()) {
			//ID
			out.println("<tr><td>Id</td><td>" + rst.getInt(1)+ "</td></tr>");
			//names
			out.println("<tr><td>First Name</td><td>" + rst.getString(2)+ "</td></tr>");
			out.println("<tr><td>Last Name</td><td>" + rst.getString(3)+ "</td></tr>");
			//email
			out.println("<tr><td>Email</td><td>" + rst.getString(4)+ "</td></tr>");
			//phone
			out.println("<tr><td>Phone </td><td>" + rst.getString(5)+ "</td></tr>");
			//address
			out.println("<tr><td>Address </td><td>" + rst.getString(6)+ "</td></tr>");
			out.println("<tr><td>City </td><td>" + rst.getString(7)+ "</td></tr>");
			out.println("<tr><td>State </td><td>" + rst.getString(8)+ "</td></tr>");
			out.println("<tr><td>Postal Code </td><td>" + rst.getString(9)+ "</td></tr>");
			out.println("<tr><td>Country </td><td>" + rst.getString(10)+ "</td></tr>");
			//user id
			out.println("<tr><td>User id </td><td>" + rst.getString(11)+ "</td></tr>");

		}

			
		out.println("</table>");


	// Make sure to close connection
		con.close();


	} catch (SQLException ex) { out.println(ex); }
	}
	
%>
</div>

</body>
</html>

