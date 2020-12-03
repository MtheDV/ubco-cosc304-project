<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Grocery Products</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"  rel="stylesheet">
</head>
<body style="padding-top: 45px">
<%@include file="header.jsp" %>
<%@include file="jdbc.jsp" %>

<div class="container text-center mt-5">
	<h1>Search for the products you want to buy:</h1>

    <div class="row justify-content-center"> 
        <div class="col-9 m-3">
			<form class="form-inline my-2 my-lg-0" method="get" action="listprod.jsp">
				<input class="form-control mr-2" type="text" name="productName" size="50">
				<input class="btn btn-outline-success my-2 my-sm-0 mr-2" type="submit" value="Submit">
				<input class="btn btn-outline-success my-2 my-sm-0 mr-2" type="reset" value="Reset"> (Leave blank for all products)
			</form>
		</div>
	</div>

	<div class="text-left">
	<%
		// Get product name to search for
		String name = request.getParameter("productName");
		if (name == null)
			name = "";

		////////////////////////////////////////////
		//Filter by category

		//ONLY ALLOWS FOR 20 DIFFERENT CATEGORIES
		/*String[] categories = new String[20];

		try ( Connection con2 = DriverManager.getConnection(url, uid, pw);) {

			PreparedStatement stmt2 =null;
			ResultSet rst2 = null;

			//finds all distict categories in database
			String sql2 = "SELECT DISTINCT(categoryName) FROM product P LEFT JOIN category C ON P.categoryId=C.categoryId";

			stmt2 = con2.prepareStatement(sql2);
			rst2 = stmt2.executeQuery();

			int count = 0;
			// Print out the ResultSet
			while (rst2.next()) {
				// For each category save into strign array
				String cat = rst2.getString(1);
				categories[count] = cat;
				count++;
			}
			// Close connection
			con2.close();


		} catch (SQLException ex) { out.println(ex); }*/

		////////////////////////////////////////////
		getConnection();
		try {

			PreparedStatement stmt=null;
			ResultSet rst = null;
			NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en","US"));

			//String sql = "SELECT categoryName, productName, productPrice, productId FROM product P LEFT JOIN category C ON P.categoryId=C.categoryId" 
			//+" WHERE productName LIKE ? ORDER BY categoryName";
			String sql = "SELECT productBrand, productModel, productPrice, productId FROM product WHERE productModel LIKE ? OR productBrand LIKE ? ORDER BY productModel";
			String prodName = "%"+name+"%";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, prodName);
			stmt.setString(2, prodName);
			rst = stmt.executeQuery();

			// Start the table
			out.println("<table class='table table-striped'><thead class='thead-dark'><tr><th colspan=1>Product Name</th><th colspan=3>Price</th></tr></thead>"); 
			// Print out the ResultSet
			while (rst.next()) {
				// For each product create a link of the form
				// addcart.jsp?id=productId&name=productName&price=productPrice
				out.println("<tr><td colspan=2><a href=product.jsp?id="+rst.getInt(4)+">"+rst.getString(1)+" "+rst.getString(2)+"</a></td><td>"+currFormat.format(rst.getDouble(3))+
							"</td><td><a href=addcart.jsp?id="+rst.getInt(4)+"&name="+rst.getString(2).replaceAll(" ", "+")+"&price="+rst.getDouble(3)+
							">Add to Cart</a></td></tr>");

				//if nothing came back from categories
				/*if (categories.length == 0){
					out.println("<tr><td>"+rst.getString(2)+"</td><td>"+currFormat.format(rst.getDouble(3))+
					"</td><td><a href=addcart.jsp?id="+rst.getInt(4)+"&name="+rst.getString(2).replaceAll(" ", "+")+"&price="+rst.getDouble(3)+
					">Add to Cart</a></td></tr>");

				} else {
					
					for (int i = 0; i < categories.length; i++){

						if (rst.getString(1).equals(categories[i])){
							//If category has already had header printed then just print values
							if (i == last){

								out.println("<tr><td colspan=2><a href=product.jsp?id="+rst.getInt(4)+">"+rst.getString(2)+"</a></td><td>"+currFormat.format(rst.getDouble(3))+
									"</td><td><a href=addcart.jsp?id="+rst.getInt(4)+"&name="+rst.getString(2).replaceAll(" ", "+")+"&price="+rst.getDouble(3)+
									">Add to Cart</a></td></tr>");
							//else print header as well as values
							} else {

							//header	
							//out.println("<table class='table table-striped'><thead class='thead-light'><tr><th colspan=4>"+rst.getString(1)+"</th></tr></thead>"); 
							out.println("<thead class='thead-light'><tr><th colspan=4>"+rst.getString(1)+"</th></tr></thead>"); 
							last = i;
							
							//product values
							out.println("<tr><td colspan=2><a href=product.jsp?id="+rst.getInt(4)+">"+rst.getString(2)+"</a></td><td>"+currFormat.format(rst.getDouble(3))+
								"</td><td><a href=addcart.jsp?id="+rst.getInt(4)+"&name="+rst.getString(2).replaceAll(" ", "+")+"&price="+rst.getDouble(3)+
								">Add to Cart</a></td></tr>");

							}

						//if there is no more values but still null spaces in categories[]	
						} else if (categories[i] == null){
							break;
						}
						
					}
				}*/
			}
			// End table
			out.println("</table>");
			// Close connection
			closeConnection();

		} catch (SQLException ex) { out.println(ex); }
		

	%>
	</div>
</div>

</body>
</html>