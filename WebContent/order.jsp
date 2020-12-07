<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">
<title>Grocery Order Processing</title>
</head>
<body style="padding-top: 45px">
<%@include file="header.jsp"%>
<%@include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>


<div class="container mt-5">
<% 
	/*// Get customer id
	String custId = request.getParameter("customerId");
	String password = request.getParameter("password");
	@SuppressWarnings({"unchecked"})*/
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
	

	String custId = ((String)session.getAttribute("customerId").toString());
	// Make connection
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " + e);
	}


	//try (Connection con = DriverManager.getConnection(url, uid, pw);) {
		getConnection();
		int id = -1;
		boolean isId = false;
		id = Integer.parseInt(custId);
		// Determine if valid customer id was entered
		/*
		try {
			// Convert id to integer
			
			// Check if customer ID exists with correct password
			PreparedStatement pstmt = con.prepareStatement("SELECT customerId FROM customer WHERE customerId = ? and password = ?", Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, id); pstmt.setString(2, password);
			ResultSet rst = pstmt.executeQuery();
			while (rst.next())
				isId = true;
		} catch (NumberFormatException e) {
			out.println("<h4>Invalid customer Id: " + e + "</h4>");
		}
		
		if (!isId)
			// Display message saying wrong user id or password
			out.println("<h4 class='text-center'>Customer Id or Password is incorrect. " +
						"<a href='javascript:history.back()'>Go Back</a></h4>");
		*/
		// Determine if there are products in the shopping cart
		boolean isProdList = productList != null;
		if (!isProdList)
			// Nothing in the product list for this session
			out.println("<h4>Your shopping cart is empty</h4>");

		// Continue if there is an order and a customer
		else {
			// Save order information to database (date and custId)

			// String sql = "INSERT INTO ordersummary (orderDate, shiptoAddress, shiptoCity, shiptoState,shiptoPostalCode, shiptoCountry, customerId) " +
			// "VALUES (GETDATE(), ?, ?, ?, ?, ?, ?)";
			// PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);	
			// pstmt.setString(1, (String)session.getAttribute("address"));
			// pstmt.setString(2, (String)session.getAttribute("city"));
			// pstmt.setString(3, (String)session.getAttribute("state"));
			// pstmt.setString(4, (String)session.getAttribute("pc"));
			// pstmt.setString(5, (String)session.getAttribute("country"));
			// pstmt.setInt(6,id);
			// pstmt.executeUpdate();

			String sql = "INSERT INTO ordersummary (orderDate, customerId) " +
			"VALUES (GETDATE(), ?)";
			PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);	
			pstmt.setInt(1,id);
			pstmt.executeUpdate();

			// Retrieve orderId from ordersummary
			int orderId = -1;
			sql = "SELECT TOP 1 orderId FROM ordersummary WHERE customerId = ? ORDER BY orderId DESC";
			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, id);
			ResultSet rst = pstmt.executeQuery();
			while (rst.next())
				orderId = rst.getInt(1);

			// Insert each item into OrderProduct table using OrderId from previous INSERT
			double totalPrice = 0;
			// Create iterator to view products
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();

				String productId = (String)product.get(0);
				String price = (String)(product.get(3).toString());
				double pr = 0;
				if (price != null)
					pr = Double.parseDouble(price);
				int qty = Integer.parseInt((String)product.get(4).toString());
				// Insert into orderproduct table
				sql = "INSERT INTO orderproduct VALUES (?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				pstmt.setInt(1, orderId); pstmt.setString(2, productId); pstmt.setInt(3, qty); pstmt.setDouble(4, pr);
				pstmt.executeUpdate();
				// Add to total product price

				totalPrice += qty*pr;
			}

			// Update total amount for order record
			
			sql = "UPDATE ordersummary SET totalAmount=? WHERE orderId = ?";
			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);	
			pstmt.setDouble(1, totalPrice);
			pstmt.setInt(2,orderId);

			pstmt.executeUpdate();
				

			// Print out order summary
			
			out.println("<h1 class=mb-3>Your Order Summary</h1>");

			out.println("<table class='table table-striped'><thead class='thead-dark'><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr></thead>"); 
				NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en","US"));

				sql = "SELECT oP.productId, productBrand, productModel, quantity, productPrice FROM orderProduct oP JOIN Product P ON oP.productId=P.productId WHERE orderId =?";
				pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				pstmt.setInt(1, orderId);
				rst = pstmt.executeQuery();
				// Print out the ResultSet
				while (rst.next()) {
					// For each product create a link of the form
					// addcart.jsp?id=productId&name=productName&price=productPrice

					out.println("<tr><td>"+rst.getInt(1)+"</td><td>"+rst.getString(2)+rst.getString(3)+"</td><td>"+rst.getInt(4)+"</td><td>"+currFormat.format(rst.getDouble(5))+"</td><td>"+currFormat.format(rst.getDouble(4)*rst.getDouble(5))+"</td></tr>");
				}
				out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
							+"<td><b>"+currFormat.format(totalPrice)+"</b></td></tr>");
				out.println("</table>");
				out.println("<h3>Order completed. Will be shipping soon...</h3>");
				pstmt = con.prepareStatement("SELECT customerId,firstName,lastName FROM customer WHERE customerId = ?");
				pstmt.setInt(1,Integer.parseInt(custId));
				rst = pstmt.executeQuery();
				while(rst.next()){
				out.println("<h5>Shipping to customer: "+ rst.getInt(1)+"</h5>");
				out.println("<h5>			Customer Name: "+ rst.getString(2)+" " +rst.getString(3)+"</h5>");
				}
				out.println("<h5>Your order reference number is: "+ orderId+"</h5>");


				

			// Clear cart if order placed successfully

			session.removeAttribute("productList");
		}

	/*} catch (Exception e) {
		out.println(e);
	}*/
%>
</div>
</BODY>
</HTML>

