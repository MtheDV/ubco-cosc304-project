<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Locale" %>

<html>
<head>
<title>Rays Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body style="padding-top: 45px">

<%@ include file="header.jsp" %>

<div class="container mt-5">
<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");

try {
    getConnection();

    /*String sql = "SELECT productReleaseYear, productBrand, productModel, productImageURL, productId, productPrice FROM product WHERE productId = ? ";
    PreparedStatement stmt = con.prepareStatement(sql);
    stmt.setInt(1, Integer.parseInt(productId));
    ResultSet rst = stmt.executeQuery();
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en","US"));*/

    // get the table names
    String sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'product'";
    PreparedStatement stmt = con.prepareStatement(sql);
    ResultSet rst = stmt.executeQuery();
    List<String> tableNames = new ArrayList<>();
    while (rst.next()) {
        tableNames.add(rst.getString(1));
    }

    // get the data in the row
    sql = "SELECT * FROM product WHERE productId = ? ";
    stmt = con.prepareStatement(sql);
    stmt.setInt(1, Integer.parseInt(productId));
    rst = stmt.executeQuery();
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(new Locale("en","US"));

    // display the data
    while(rst.next()) {
        out.println("<div class='d-flex justify-content-between'>");
            out.println("<div>");
                out.println("<h1>"+rst.getInt(8)+" "+rst.getString(4)+" "+rst.getString(7)+"</h1>");
                if(rst.getString(3) != null)
                    out.println("<img src="+rst.getString(3)+" alt='"+rst.getString(7)+" image'>");
            out.println("</div>");
            out.println("<div>");
                out.println("<h4 class='mt-4'>Price: "+currFormat.format(rst.getDouble(2))+"</h4>");
                out.println(
                    "<div>"+
                        "<a class='btn btn-warning mr-3' href='addcart.jsp?id="+rst.getInt(1)+"&name="+rst.getString(4).replaceAll(" ","+")+"&price="+rst.getDouble(2)+"'>Add To Cart</a>"+
                        "<a class='btn btn-primary' href='listprod.jsp'>Continue Shopping</a>"+
                    "</div>"
                );
            out.println("</div>");
        out.println("</div>");

        // tab buttons
        out.println(
            "<div class='btn-group m-3'>"+
                "<button class='btn btn-secondary' onclick=openTab('carData') id='originalOpen' checked>Car Details</button>" +
                "<button class='btn btn-secondary' onclick=openTab('reviews')>Reviews</button>" +
            "</div>"
        );
        
        // display table of car data
        out.println("<table id='carData' class='table tabDetails'>" +
                    "<thead><td>Type</td><td>Description</td></thead>");
        for(int i = 5; i < tableNames.size(); i++) {
            out.println("<tr><td>"+tableNames.get(i)+"</td><td>"+rst.getString(i)+"</td></tr>");
        }
        out.println("</table>");

        // start review section
        out.println("<div id='reviews' class='tabDetails'>" +
                    "<button class='btn btn-outline-primary'><a href='addReview.jsp?id="+productId+"'>Add a Review</a></button>" +
                    "<h2>Reviews:</h2>");
        
        // get the reviews
        sql = "SELECT userid, reviewRating, reviewDate, reviewComment FROM review r JOIN customer c on r.customerId = c.customerId WHERE productId = ? ";
        stmt = con.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(productId));
        rst = stmt.executeQuery();
        while (rst.next()) {
            // display the reviews
            out.println(
                "<div>" +
                    "<h4>"+rst.getInt(2)+" Stars</h4>" +
                    "<h6>"+rst.getString(1)+" on "+rst.getDate(3)+" says:</h2>" +
                    "<p>"+rst.getString(4)+"</p>" +
                "</div>"
            );
        }
        out.println("</div>");
    }

    closeConnection();

} catch (SQLException ex) { out.println(ex); }
%>
</div>

</body>
<script>
    document.getElementById("originalOpen").click();

    function openTab(tab) {
        tabs = document.getElementsByClassName("tabDetails");
        for (i = 0; i < tabs.length; i++)
            tabs[i].style.display = "none";

        clickTab = document.getElementById(tab);
        clickTab.style.display = "block";
    }
</script>
</html>

