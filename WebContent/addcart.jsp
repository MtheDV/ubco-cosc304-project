<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<title>Grocery Products</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"  rel="stylesheet">
</head>
<body style="padding-top: 45px">
<%@include file="header.jsp" %>
<%@include file="jdbc.jsp" %>
<%
// Get the current list of products
	//session.removeAttribute("productList");

	@SuppressWarnings({"unchecked"})
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
	
	if (productList == null)
	{	// No products currently in list.  Create a list.
		productList = new HashMap<String, ArrayList<Object>>();
	}

	// Add new product selected
	// Get product information
		String id = request.getParameter("id");
		String brand = request.getParameter("brand");
		String model = request.getParameter("model");
		String price = request.getParameter("price");
		String quantity = request.getParameter("qty");

		Object customerId = session.getAttribute("customerId");
		int cid = -1;
		if (customerId != null) {
			cid = Integer.parseInt(customerId.toString());

			try{
				getConnection();
				String sql = "INSERT INTO incart (customerId,productId,quantity,price) VALUES (?,?,?,?)";
				PreparedStatement stmt = con.prepareStatement(sql);
				stmt.setInt(1,cid);
				stmt.setInt(2,Integer.parseInt(id));
				stmt.setInt(3,Integer.parseInt(quantity));
				stmt.setDouble(4,Double.parseDouble(price));
				stmt.executeUpdate();
				closeConnection();

			}catch(Exception e){
				out.println(e);
			}
		}
			


	// Store product information in an ArrayList
	ArrayList<Object> product = new ArrayList<Object>();
	product.add(id);
	product.add(brand);
	product.add(model);
	product.add(price);
	product.add(quantity); 

	// Update quantity if add same item to order again
	if (productList.containsKey(id))
	{	product = (ArrayList<Object>) productList.get(id);
		int curAmount = Integer.parseInt((String)product.get(4).toString());
		product.set(4, ++curAmount);
		if (customerId != null) {
			try{
				String sql2 = "UPDATE incart SET quantity=? WHERE productId = ? AND customerId = ?";
				PreparedStatement stmt2 = con.prepareStatement(sql2);
				stmt2.setInt(1,Integer.parseInt(quantity));
				stmt2.setInt(2,Integer.parseInt(id));
				stmt2.setInt(3,cid);
				stmt2.executeUpdate();
			}catch(Exception e){
				out.println(e);
			}
		}
	}
	else
		productList.put(id,product);
	
	if(Integer.parseInt(quantity)==0){
		productList.remove(id);
		if (customerId != null) {
			try{
				String sql3 = "DELETE FROM incart WHERE productId = ? AND customer Id = ?";
				PreparedStatement stmt3 = con.prepareStatement(sql3);
				stmt3.setInt(1,Integer.parseInt(id));
				stmt3.setInt(2,cid);
				stmt3.executeUpdate();
			}catch(Exception e){
				out.println(e);
			}
		}
	}

	session.setAttribute("productList", productList);
%>
</body>
</html>
<jsp:forward page="showcart.jsp" />	

