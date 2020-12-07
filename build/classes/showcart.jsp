<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Grocery Your Shopping Cart</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"  rel="stylesheet">
</head>
<body style="padding-top: 45px">
<%@include file="header.jsp" %>
<%@include file="jdbc.jsp" %>
<div class="container wrapper text-center mt-5">
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
Object customerId = session.getAttribute("customerId");

if (productList == null){
	productList = new HashMap<String, ArrayList<Object>>();
	if (customerId != null) {
		int cid = Integer.parseInt(customerId.toString());
		try{
			//Retrieve cart data from DB
			getConnection();
			String sql = "SELECT C.productId,quantity,price,productBrand,productModel" +
							" FROM incart C JOIN product P ON c.productId = P.productId WHERE customerId = ?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1,cid);
			ResultSet rst = stmt.executeQuery();
			Object id = (Integer)rst.getInt(1);
			Object quantity = (Integer)rst.getInt(2);
			Object price = (Double)rst.getDouble(3);
			Object brand = rst.getString(4);
			Object model = rst.getString(5);

			ArrayList<Object> product = new ArrayList<Object>();
			product.add(id);
			product.add(brand);
			product.add(model);
			product.add(price);
			product.add(quantity);
		}catch(Exception e){
			out.println("<H1>Your shopping cart is empty!</H1>");
		}
	}
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en","US"));

	if (customerId == null) {
		out.println("<div class='alert alert-warning'>Please login to save your shopping cart.</div>");
	}

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table class='table table-striped mt-4'><thead class='thead-dark'><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></thead>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();

		if (product.size() < 5)

		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}

		String model = (String)product.get(2);

		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+" "+product.get(2)+"</td>");

		out.print(

			"<td>"+
				"<form method=post action=addcart.jsp?id="+product.get(0)+"&brand="+
				product.get(1)+"&model="+model.replaceAll(" ", "+")+"&price="+product.get(3)+">"+
				"<input name='qty' type='text' value='" + product.get(4) +"'>" +
				"<button class='btn-dark mr-3 ml-3 btn-sm' type='submit'>Save</button>"+
				"<a class='btn btn-warning mr-3 btn-sm' href=addcart.jsp?id="+product.get(0)+"&brand="+
				product.get(1)+"&model="+model.replaceAll(" ", "+")+"&price="+product.get(3)+"&qty=0>Remove Item</a>"+
			"</form>"+
			"</td>");
		
		//out.print("<script> function saveqty(){var quantity = document.getElementByName('quantity')};</script>");
		//product.set(3,request.getParameter("quantity"));
		Object price = product.get(3);
		Object itemqty = product.get(4);
		//Object itemqty = request.getParameter("quan");
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		//out.println(qty);
		//if(qty == 0)
		//	productList.remove(entry);

		out.print("<td>"+currFormat.format(pr)+"</td>");
		out.print("<td>"+currFormat.format(pr*qty)+"</td>");
		//out.print("<td><a href=addcart.jsp?id="+product.get(0)+"&name="+product.get(1)+"&price="+product.get(2)+"&quan="+0+">Remove From Cart</a></td></tr>");
		out.println("</tr>");

		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td><b>"+currFormat.format(total)+"</b></td></tr>");
	out.println("</table>");

	out.println("");
}
%>
	<div class="mt-3">
			<button class='btn btn-light m-3'><a href='checkout.jsp'>Check Out</a></button>
			<button class='btn btn-light m-3'><a href='listprod.jsp'>Continue Shopping</a></button>
	</div>
</div>
</body>
</html> 

