<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ include file="jdbc.jsp" %>

<!-- Checking whether user is logged in -->
<%@ include file="auth.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Administrator Page</title>
    </head>
    <body style="padding-top: 45px">
        <%@include file="header.jsp"%>
        <div class="container mt-5">
            <h2 class="mb-3">Administrator Sales Report by Day</h2>

            <%
                try {
                    // Setup connection
                    getConnection();

                    // User Id for getting order data
                    String userid = (String)session.getAttribute("authenticatedUser");
                    NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en","US"));

                    // Write SQL query that prints out total order amount by day
                    //String sql = "SELECT max(orderDate), max(totalAmount) FROM ordersummary os JOIN customer c on os.customerId = c.customerId WHERE userid = ? GROUP BY orderDate";
                    String sql = "SELECT max(orderDate), max(totalAmount) FROM ordersummary GROUP BY YEAR(orderDate), MONTH(orderDate), DAY(orderDate)";

                    // Create SQL statement with userid
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    //pstmt.setString(1, userid);
                    ResultSet rst = pstmt.executeQuery();
                    // Start drawing table data
                    out.println("<table class='table table-striped'><thead class='thead-dark'><tr><td>Order Date</td><td>Total Order Amount</td></tr></thead>");
                    while(rst.next()) {
                        // Each row shows order date and total order amount from results
                        out.println("<tr><td>" + rst.getDate(1) + "</td><td>" + currFormat.format(rst.getDouble(2)) + "</td></tr>");
                    }
                    out.println("</table>");

                    // Close connection
                    closeConnection();
                } catch(SQLException ex) {
                    out.println(ex);
                }
            %>
        </div>

    </body>
</html>

