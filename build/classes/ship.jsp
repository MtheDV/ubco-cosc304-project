<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body style="padding-top: 60px">
        
<%@ include file="header.jsp" %>

<%

	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";

	//Get order id
	String orderid = request.getParameter("id");
	int id = Integer.parseInt(orderid);    
	
	try ( Connection con = DriverManager.getConnection(url, uid, pw);) {
		String sql = "SELECT orderId FROM ordersummary WHERE orderId =?";
		PreparedStatement stmt=con.prepareStatement(sql);
		//Start a transaction (turn-off auto-commit)
		con.setAutoCommit(false);
		stmt.setInt(1,id);
		ResultSet rst = stmt.executeQuery();
		con.commit();
		
		//Check if valid order id
		if(rst.next()){
			//Retrieve all items in order with given id
			String sql2 = "SELECT OP.productId, OP.quantity, PI.quantity FROM productinventory PI JOIN orderproduct OP"+
			" ON OP.productId=PI.productId"+
			" WHERE orderId = ? AND warehouseId = 1";
			PreparedStatement stmt2 = con.prepareStatement(sql2);
			stmt2.setInt(1,rst.getInt(1));
			ResultSet rst2 = stmt2.executeQuery();
			con.commit();
			boolean canShip = true;
			while(rst2.next()){
				//For each item verify sufficient quantity available in warehouse 1.
				if((rst2.getInt(3)-rst2.getInt(2))<0){
					canShip=false;
					con.rollback(); // If any item does not have sufficient inventory, cancel transaction and rollback. 
					out.println("<h2>Shipment not done, insufficient inventory for product id:"+rst2.getInt(1)+"</h2>");
				}else{
					out.println("<h4>Ordered Product: "+rst2.getInt(1)+"	Quantity Ordered: "
					+rst2.getInt(2)+"	Previous Inventory: "+ rst2.getInt(3)+"	New Inventory: "+(rst2.getInt(3)-rst2.getInt(2))+"</h4>");
					// Update Inventory for each item in shipment
					String sql3 = "UPDATE productinventory SET quantity = ? WHERE productId = ?";
					PreparedStatement stmt5 = con.prepareStatement(sql3);
					stmt5.setInt(1,rst2.getInt(3)-rst2.getInt(2));
					stmt5.setInt(2,rst2.getInt(1));
					stmt5.executeUpdate();
				}
			}
			con.commit();
			if(canShip){
				String sql4 = "INSERT INTO shipment (shipmentDate, warehouseId) VALUES (GETDATE(),1)";
				PreparedStatement stmt3 = con.prepareStatement(sql4);
				stmt3.executeUpdate();
				out.println("<h2>Shipment has been successfully processed</h2>");
				//Auto-commit should be turned back on
				con.setAutoCommit(true);
			}
			//Create a new shipment record
		}else{
			out.println("<h1 align='center'>Invalid Order ID</h1>");
		}
		
	} catch(SQLException ex){ 
		out.println(ex); 
		//con.rollback();
	}
	
%>			

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
