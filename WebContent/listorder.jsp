<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"  rel="stylesheet">
	<title>Grocery Order List</title>
</head>
<body style="padding-top: 45px">

	<%@include file="header.jsp" %>

	<div class="container mt-5">
		<h1 class="mb-3">Order List</h1>

		<%
		String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
		String uid = "SA";
		String pw = "YourStrong@Passw0rd";
		//Note: Forces loading of SQL Server driver
		try
		{	// Load driver class
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			out.println("ClassNotFoundException: " +e);
		}

		// Useful code for formatting currency values:
		// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
		// out.println(currFormat.format(5.0);  // Prints $5.00

		// Make connection
		try(Connection con = DriverManager.getConnection(url,uid,pw);
		Statement stmt = con.createStatement();){
			String sql = "SELECT OS.orderId,OS.orderDate,C.customerId,C.firstName,C.lastName, OS.totalAmount" +
			" FROM ordersummary AS OS JOIN customer AS C ON OS.customerId = C.customerId";
			String sql2 = "SELECT productId, quantity, price"+
			" FROM orderproduct AS OP JOIN ordersummary AS OS ON OP.orderId = OS.orderId"+
			" WHERE OS.orderId = ?";
			PreparedStatement pstmt = con.prepareStatement(sql2);
			ResultSet rst = stmt.executeQuery(sql);
			NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en","US"));
			//bonus, filter by cateogry
			out.println("<table class='table'><thead class='thead-dark'><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>Customer Name</th><th>Total Amount</th></tr></thead>");
			while(rst.next()){
				out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getDate(2)+ " "
				+rst.getTime(2)+"</td><td>"+ rst.getInt(3)+
				"</td><td>"+ rst.getString(4) + " " + rst.getString(5)+ "</td><td>"
				+currFormat.format(rst.getDouble(6))+ "</td></tr>");
				pstmt.setInt(1,rst.getInt(1));
				ResultSet rst2 = pstmt.executeQuery();
				out.println("<tr align='right'><td colspan=5><table class='table table-bordered table-sm'><thead class='thead-light'><tr><th>Product ID</th><th>Quantity</th><th>Price</th></tr></thead>");
				while(rst2.next()){
					out.println("<tr><td>" + rst2.getInt(1)+ "</td><td>" + rst2.getInt(2)+ "</td><td>" + currFormat.format(rst2.getDouble(3)) + "</td></tr>");
				}
				rst2.close();
				out.println("</table></td></tr>");
			}
			out.println("</table>");
			con.close();

		}catch(SQLException ex){
			out.println(ex);
		}

		// Write query to retrieve all order summary records

		// For each order in the ResultSet

			// Print out the order summary information
			// Write a query to retrieve the products in the order
			//   - Use a PreparedStatement as will repeat this query many times
			// For each product in the order
				// Write out product information 

		// Close connection
		%>
	</div>

</body>
</html>

