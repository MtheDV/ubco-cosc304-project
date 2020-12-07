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

<div class="text-center mt-5">
	<h1>Search for the products you want to buy:</h1>

    <div class="row justify-content-center"> 
        <div class="col-7 m-3">
			<form class="form-inline my-2 my-lg-0" method="get" action="listprod.jsp">
				<input class="form-control mr-2" type="text" name="productBrand" size="50">
				<input class="btn btn-outline-success my-2 my-sm-0 mr-2" type="submit" value="Submit">
				<input class="btn btn-outline-success my-2 my-sm-0 mr-2" type="reset" value="Reset"> (Leave blank for all products)
			</form>
		</div>
	</div>

	<div class="text-left">
	<%
		// Get product brand to search for
		String name = request.getParameter("productBrand");
		if (name == null)
			name = "";

		////////////////////////////////////////////
		//Filter by category

		//ONLY ALLOWS FOR 20 DIFFERENT CATEGORIES
		String[] categories = new String[20];

		try ( Connection con2 = DriverManager.getConnection(url, uid, pw);) {

			PreparedStatement stmt2 =null;
			ResultSet rst2 = null;

			//finds all distict categories in database
			String sql2 = "SELECT DISTINCT(productBrand) FROM product";

			stmt2 = con2.prepareStatement(sql2);
			rst2 = stmt2.executeQuery();

			int count = 0;
			// Print out the ResultSet
			while (rst2.next()) {
				// For each category save into string array
				String cat = rst2.getString(1);
				categories[count] = cat;
				count++;
			}
			// Close connection
			con2.close();


		} catch (SQLException ex) { out.println(ex); }

		

		////////////////////////////////////////////
		// Start the table
		//out.println("<table class='table table-striped'><thead class='thead-dark'><tr><th colspan=1>Product Name</th><th colspan=1>Product Year</th><th colspan=2>Price</th></tr></thead>"); 
		out.println("<div class='d-flex flex-wrap align-items-stretch justify-content-center p-2'>");

		
		try {
			getConnection();
			PreparedStatement stmt=null;
			ResultSet rst = null;
			NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en","US"));

			String sql = "SELECT productBrand, productModel, productReleaseYear, productPrice, productId, productImageUrl FROM product WHERE productBrand LIKE ? OR productModel LIKE ? OR productReleaseYear LIKE ? ORDER BY productBrand, productReleaseYear DESC;";

			String prodName = "%"+name+"%";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, prodName);
			stmt.setString(2, prodName);
			stmt.setString(3, prodName);
			rst = stmt.executeQuery();

			int last = 21;

			// Print out the ResultSet

			while (rst.next()) {
				// For each product create a link of the form
				// addcart.jsp?id=productId&name=productName&price=productPrice

				//if nothing came back from categories
				if (categories.length == 0){
					out.println("<div class='bg-light p-3 m-3 rounded'><a href=product.jsp?id="+rst.getInt(5)+"><img height=200 style='clip-path:margin-box' class='rounded' src="+rst.getString(6)+"><h3>"+rst.getString(1)+" "+rst.getString(2)+"</h3></a><h4>"+rst.getInt(3)+
								"</h4><h4>"+currFormat.format(rst.getDouble(4))+"</h4><br><a class='btn btn-primary' href=addcart.jsp?id="+rst.getInt(5)+"&brand="+rst.getString(1)+"&model="+rst.getString(2).replaceAll(" ","+")+
								"&price="+rst.getDouble(4)+"&qty=1>Add To Cart</a></div>");
				} else {
					
					for (int i = 0; i < categories.length; i++){

						if (rst.getString(1).equals(categories[i])){
							//If category has already had header printed then just print values
							if (i == last){

								out.println("<div class='bg-light p-3 m-3 rounded'><a href=product.jsp?id="+rst.getInt(5)+"><img height=200 style='clip-path:margin-box' class='rounded' src="+rst.getString(6)+"><h3>"+rst.getString(1)+" "+rst.getString(2)+"</h3></a><h4>"+rst.getInt(3)+
											"</h4><h4>"+currFormat.format(rst.getDouble(4))+"</h4><br><a class='btn btn-primary' href=addcart.jsp?id="+rst.getInt(5)+"&brand="+rst.getString(1)+"&model="+rst.getString(2).replaceAll(" ","+")+
											"&price="+rst.getDouble(4)+"&qty=1>Add To Cart</a></div>");
							//else print header as well as values
							} else {
								last = i;
								
								//product values 
								//<a href=addcart.jsp?id="+rst.getInt(5)+"&brand="+rst.getString(1)+"&model="+rst.getString(2).replaceAll(" ","+")+"&price="+rst.getDouble(4)+">Add To Cart</a>
							

								out.println("<div class='bg-light p-3 m-3 rounded'><a href=product.jsp?id="+rst.getInt(5)+"><img height=200 style='clip-path:margin-box' class='rounded' src="+rst.getString(6)+"><h3>"+rst.getString(1)+" "+rst.getString(2)+"</h3></a><h4>"+rst.getInt(3)+
											"</h4><h4>"+currFormat.format(rst.getDouble(4))+"</h4><br><a class='btn btn-primary' href=addcart.jsp?id="+rst.getInt(5)+"&brand="+rst.getString(1)+"&model="+rst.getString(2).replaceAll(" ","+")+
											"&price="+rst.getDouble(4)+"&qty=1>Add To Cart</a></div>");

							}

						//if there is no more values but still null spaces in categories[]	
						} else if (categories[i] == null){
							break;
						}
						
					}
				}
			}
			// End table
			out.println("</div>");
			//out.println("</table>");
			// Close connection
			closeConnection();

		} catch (SQLException ex) { out.println(ex); }
		

	%>
	</div>
</div>

</body>
</html>